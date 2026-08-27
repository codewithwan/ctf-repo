import struct, sys
from unicorn import *
from unicorn.x86_const import *

BIN = 'void'
data = open(BIN, 'rb').read()
STACK_TOP = 0x80000000

def va(v):
    if 0x1000 <= v < 0x1000+0xcb9: return v
    if 0x2000 <= v < 0x2000+0x1058: return v
    if 0x4d50 <= v < 0x4d50+0x2c0: return v-0x4d50+0x3d50
    return None

def read_cstr(uc, addr, limit=4096):
    out = bytearray()
    for i in range(limit):
        b = uc.mem_read(addr+i, 1)[0]
        if b == 0: break
        out.append(b)
    return bytes(out)

def build_uc():
    uc = Uc(UC_ARCH_X86, UC_MODE_64)
    for base, size in [(0x0,0x1000),(0x1000,0x1000),(0x2000,0x1000),(0x3000,0x2000),(0x5000,0x2000)]:
        uc.mem_map(base, size, UC_PROT_ALL)
    uc.mem_map(STACK_TOP - 0x100000, 0x100000, UC_PROT_ALL)
    for v in range(0x1000, 0x1000+0xcb9):
        o = va(v)
        if o is not None: uc.mem_write(v, data[o:o+1])
    for v in range(0x2000, 0x2000+0x1058):
        o = va(v)
        if o is not None: uc.mem_write(v, data[o:o+1])
    for v in range(0x4d50, 0x4d50+0x2c0):
        o = va(v)
        if o is not None: uc.mem_write(v, data[o:o+1])
    return uc

INPUT = b''

def make_hooks(uc, state_sink=None):
    def do_strlen(uc):
        return len(read_cstr(uc, uc.reg_read(UC_X86_REG_RDI)))
    def do_puts(uc):
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
        a = uc.mem_read(rdi, rdx); b = uc.mem_read(rsi, rdx)
        return 0 if a == b else 1
    def do_strncmp(uc):
        rdi = uc.reg_read(UC_X86_REG_RDI); rsi = uc.reg_read(UC_X86_REG_RSI); n = uc.reg_read(UC_X86_REG_RDX)
        a = read_cstr(uc, rdi, n); b = read_cstr(uc, rsi, n)
        for i in range(n):
            xa = a[i] if i < len(a) else 0
            xb = b[i] if i < len(b) else 0
            if xa != xb: return -1 if xa < xb else 1
        return 0
    def do_strcmp(uc):
        rdi = uc.reg_read(UC_X86_REG_RDI); rsi = uc.reg_read(UC_X86_REG_RSI)
        a = read_cstr(uc, rdi); b = read_cstr(uc, rsi)
        return 0 if a == b else (1 if a > b else -1)
    def do_printf(uc):
        return 0
    def do_setvbuf(uc):
        return 0
    def do_ptrace(uc):
        return 0
    def do_chkfail(uc):
        return 0
    PLT = {
        0x10e0: do_strncmp, 0x10f0: do_puts, 0x1100: do_strlen, 0x1110: do_chkfail,
        0x1120: do_memcmp, 0x1130: do_fgets, 0x1140: do_strcmp, 0x1150: do_ptrace,
        0x1160: do_printf, 0x1170: do_setvbuf,
    }
    def hook_plt(uc, address, size, user_data):
        ret = PLT[address](uc)
        uc.reg_write(UC_X86_REG_RAX, ret)
        rsp = uc.reg_read(UC_X86_REG_RSP)
        rip = struct.unpack('<Q', uc.mem_read(rsp, 8))[0]
        uc.reg_write(UC_X86_REG_RSP, rsp + 8)
        uc.reg_write(UC_X86_REG_RIP, rip)
    for a in PLT:
        uc.hook_add(UC_HOOK_CODE, hook_plt, None, a, a)
    if state_sink is not None:
        frame = STACK_TOP - 0x2000 - 0x258
        def hook_end(uc, address, size, user_data):
            state_sink['state'] = bytes(uc.mem_read(frame + 0xd0, 0x20))
        uc.hook_add(UC_HOOK_CODE, hook_end, None, 0x16a4, 0x16a4)

def real_vm(payload):
    global INPUT
    inp = b'0xV01D{' + payload + b'}'
    INPUT = inp + b'\n'
    uc = build_uc()
    rsp = STACK_TOP - 0x2000
    uc.reg_write(UC_X86_REG_RSP, rsp)
    uc.reg_write(UC_X86_REG_RBP, rsp - 0x8)
    sink = {}
    make_hooks(uc, sink)
    try:
        uc.emu_start(0x1180, 0x16ce)
    except UcError as e:
        return None
    return sink.get('state')

if __name__ == '__main__':
    payload = sys.argv[1].encode() if len(sys.argv) > 1 else b'A'*32
    print(real_vm(payload).hex())
