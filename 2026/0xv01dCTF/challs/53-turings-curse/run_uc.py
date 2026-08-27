import struct
from unicorn import *
from unicorn.x86_const import *

BIN = 'void'
data = open(BIN, 'rb').read()

BASE = 0x0
STACK_TOP = 0x80000000
STACK = STACK_TOP - 0x400000  # big stack

uc = Uc(UC_ARCH_X86, UC_MODE_64)

# map segments
uc.mem_map(0x0, 0x1000, UC_PROT_ALL)
uc.mem_map(0x1000, 0x1000, UC_PROT_ALL)
uc.mem_map(0x2000, 0x1000, UC_PROT_ALL)
uc.mem_map(0x3000, 0x2000, UC_PROT_ALL)   # 0x3000-0x5000 (eh_frame etc.)
uc.mem_map(0x5000, 0x2000, UC_PROT_ALL)   # data/bss 0x5000-0x7000
uc.mem_map(STACK_TOP - 0x100000, 0x100000, UC_PROT_ALL)

def va(v):
    if 0x1000 <= v < 0x1000+0xcb9: return v
    if 0x2000 <= v < 0x2000+0x1058: return v
    if 0x4d50 <= v < 0x4d50+0x2c0: return v-0x4d50+0x3d50
    return None

for v in range(0x1000, 0x1000+0xcb9):
    off = va(v)
    if off is not None:
        uc.mem_write(v, data[off:off+1])
for v in range(0x2000, 0x2000+0x1058):
    off = va(v)
    if off is not None:
        uc.mem_write(v, data[off:off+1])
for v in range(0x4d50, 0x4d50+0x2c0):
    off = va(v)
    if off is not None:
        uc.mem_write(v, data[off:off+1])

# ------- hooks for libc -------
OUTPUT = []
INPUT = b''
INPUT_PTR = 0

def read_cstr(addr, limit=4096):
    out = bytearray()
    for i in range(limit):
        b = uc.mem_read(addr+i, 1)[0]
        if b == 0: break
        out.append(b)
    return bytes(out)

def hook_code(uc, address, size, user_data):
    pass

def hook_intr(uc, intno, user_data):
    pass

def do_strlen(uc):
    rdi = uc.reg_read(UC_X86_REG_RDI)
    return len(read_cstr(rdi))

def do_puts(uc):
    rdi = uc.reg_read(UC_X86_REG_RDI)
    OUTPUT.append(b'puts:' + read_cstr(rdi) + b'\n')
    return 0

def do_fgets(uc):
    rdi = uc.reg_read(UC_X86_REG_RDI)
    rsi = uc.reg_read(UC_X86_REG_RSI)
    buf = INPUT[:rsi-1] + b'\x00'
    uc.mem_write(rdi, buf)
    return rdi

def do_memcmp(uc):
    rdi = uc.reg_read(UC_X86_REG_RDI)
    rsi = uc.reg_read(UC_X86_REG_RSI)
    rdx = uc.reg_read(UC_X86_REG_RDX)
    a = uc.mem_read(rdi, rdx)
    b = uc.mem_read(rsi, rdx)
    return 0 if a == b else 1

def do_strncmp(uc):
    rdi = uc.reg_read(UC_X86_REG_RDI)
    rsi = uc.reg_read(UC_X86_REG_RSI)
    rdx = uc.reg_read(UC_X86_REG_RDX)
    a = read_cstr(rdi, rdx)
    b = read_cstr(rsi, rdx)
    n = rdx
    for i in range(n):
        xa = a[i] if i < len(a) else 0
        xb = b[i] if i < len(b) else 0
        if xa != xb:
            return -1 if xa < xb else 1
    return 0

def do_strcmp(uc):
    rdi = uc.reg_read(UC_X86_REG_RDI)
    rsi = uc.reg_read(UC_X86_REG_RSI)
    a = read_cstr(rdi)
    b = read_cstr(rsi)
    return 0 if a == b else (1 if a > b else -1)

def do_printf(uc):
    rdi = uc.reg_read(UC_X86_REG_RDI)
    rsi = uc.reg_read(UC_X86_REG_RSI)
    fmt = read_cstr(rsi)
    # only %s supported; rdx = arg
    if b'%s' in fmt:
        rdx = uc.reg_read(UC_X86_REG_RDX)
        s = read_cstr(rdx)
        OUTPUT.append(b'printf:' + fmt.replace(b'%s', s) + b'\n')
    else:
        OUTPUT.append(b'printf:' + fmt + b'\n')
    return 0

def do_setvbuf(uc):
    return 0

def do_ptrace(uc):
    return 0

def do_chkfail(uc):
    OUTPUT.append(b'STACK CHK FAIL\n')
    return 0

PLT = {
    0x10e0: do_strncmp,
    0x10f0: do_puts,
    0x1100: do_strlen,
    0x1110: do_chkfail,
    0x1120: do_memcmp,
    0x1130: do_fgets,
    0x1140: do_strcmp,
    0x1150: do_ptrace,
    0x1160: do_printf,
    0x1170: do_setvbuf,
}

def hook_plt(uc, address, size, user_data):
    fn = PLT.get(address)
    if fn is None:
        OUTPUT.append(b'UNHOOKED PLT %x' % address)
        uc.emu_stop()
        return
    ret = fn(uc)
    uc.reg_write(UC_X86_REG_RAX, ret)
    # emulate ret: pop return address
    rsp = uc.reg_read(UC_X86_REG_RSP)
    rip = struct.unpack('<Q', uc.mem_read(rsp, 8))[0]
    uc.reg_write(UC_X86_REG_RSP, rsp + 8)
    uc.reg_write(UC_X86_REG_RIP, rip)

def run(input_bytes):
    global INPUT, OUTPUT
    INPUT = input_bytes + b'\n'
    OUTPUT = []
    rsp = STACK_TOP - 0x2000
    uc.reg_write(UC_X86_REG_RSP, rsp)
    uc.reg_write(UC_X86_REG_RBP, rsp - 0x8)
    for addr in PLT:
        uc.hook_add(UC_HOOK_CODE, hook_plt, None, addr, addr)
    try:
        uc.emu_start(0x1180, 0x16ce, count=0, timeout=0)
    except UcError as e:
        return 'ERR ' + str(e)
    return b''.join(OUTPUT).decode('latin1', 'replace')

if __name__ == '__main__':
    import sys
    inp = sys.argv[1].encode() if len(sys.argv) > 1 else b'0xV01D{AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA}'
    print(run(inp))
