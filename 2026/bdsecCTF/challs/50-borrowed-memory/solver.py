import re
M=0xffffffff
# 1) PRNG fill 0x800 bytes
tbl=bytearray(0x800)
eax=0x91e10da5
for rdx in range(0x800):
    ecx=(eax+rdx+0x45d9f3b)&M
    eax=ecx
    eax=(eax^((eax<<13)&M))&M
    eax=(eax^(eax>>17))&M
    eax=(eax^((eax<<5)&M))&M
    tbl[rdx]=(eax>>11)&0xff
# 2) apply overwrites parsed in-order from disasm
regs={r:0 for r in ['eax','ebx','ecx','edx','esi','edi','ebp','r8d','r9d','r10d','r11d','r12d','r13d','r14d','r15d']}
r16={'ax':'eax','bx':'ebx','cx':'ecx','dx':'edx','si':'esi','di':'edi','bp':'ebp',
     'r8w':'r8d','r9w':'r9d','r10w':'r10d','r11w':'r11d','r12w':'r12d','r13w':'r13d','r14w':'r14d','r15w':'r15d'}
def putv(addr,val,n):
    off=addr-0x4080
    if 0<=off<0x800-n+1:
        for i in range(n): tbl[off+i]=(val>>(8*i))&0xff
for line in open('main_full.asm'):
    m=re.search(r'\bmov (e[a-z]+|r\d+d), (0x[0-9a-f]+)\b',line)
    if m and m.group(1) in regs:
        regs[m.group(1)]=int(m.group(2),16)&M; continue
    m=re.search(r'mov (byte|word|dword) \[0x0000([0-9a-f]+)\], (0x[0-9a-f]+|[a-z0-9]+)',line)
    if m:
        sz={'byte':1,'word':2,'dword':4}[m.group(1)]; addr=int(m.group(2),16); src=m.group(3)
        if src.startswith('0x'): val=int(src,16)
        elif src in r16: val=regs[r16[src]]&0xffff
        elif src in regs: val=regs[src]
        else: continue
        putv(addr,val,sz)
import sys
open('table.bin','wb').write(tbl)
print("table built. word[0x40a0]=0x%04x (expect 0x7d95)"%(tbl[0x20]|tbl[0x21]<<8))
print("si_0 = 0x%x"%((tbl[0x20]|tbl[0x21]<<8)^0x7c31))

# ---- walk: recover si chain ----
def rol16(x,n): n&=15; return ((x<<n)|(x>>(16-n)))&0xffff
t=tbl
def b(i): return t[i] if 0<=i<len(t) else 0   # table byte (0x4080-based idx)
si=(t[0x20]|t[0x21]<<8)^0x7c31
r11=0xbeef; v8=0x5a5a; va=0x0000
chain=[]; ops=[]
for step in range(12):
    op=(((si>>3)&0xff) ^ b(si))&0xff
    ops.append(hex(op))
    chain.append(si)
    r15=((( (v8&0xff) - 0x5a)&0xff)%7)+1
    if op==0xc2:
        r10=((b(si+2)<<8)|b(si+3)) ^ (r11&0xffff)
    elif op==0xc3:
        dw=(v8 | (va<<16))&0xffffffff
        r10=(((b(si)<<8)|b(si+1)) ^ dw) + si
    elif op==0xc0:
        r10=(~rol16(((b(si+6)<<8)|b(si+5)), r15))&0xffff
    elif op==0xc1:
        r10=-1  # need OOB memory; handle later
    else:
        r10=-1
    si_next=r10&0xffff
    # state updates for next step
    r11=(r11-0x111)&0xffff
    v8=(v8+0x101)&0xffff
    va=(va+0x23d)&0xffff
    si=si_next
print("opcodes:", ops)
print("si chain:", [hex(x) for x in chain])
print("addresses (si+0x4000):", [hex(x+0x4000) for x in chain])
print("decimal:", [x+0x4000 for x in chain])
