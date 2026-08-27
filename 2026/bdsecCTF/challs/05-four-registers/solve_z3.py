from z3 import *
import time
N=14
INIT=[0x13579bdf,0x2468ace0,0x0badf00d,0xc001d00d]
TARGET=[0xd0f7f5a4,0x71d63782,0x2c458dac,0x8c64de6c]
# op index: 0 MOVI,1 ADD,2 XOR,3 ROL,4 SWAP,5 MIX
OPB=[0x13,0x27,0x39,0x4b,0x5d,0x6f]
s=Solver()
op=[BitVec(f'op{i}',8) for i in range(N)]
d =[BitVec(f'd{i}',32) for i in range(N)]
a =[BitVec(f'a{i}',32) for i in range(N)]
def rol(x,n):  # n BitVec32, x BitVec32; n in 1..31 guaranteed by caller
    n=n&31
    return RotateLeft(x,n)
def regsel(regs,idx):
    return If(idx==0,regs[0],If(idx==1,regs[1],If(idx==2,regs[2],regs[3])))
# constraints on op/d/a
for i in range(N):
    s.add(ULE(op[i],5))
    s.add(ULE(d[i],3))
    # a range depends on op
    s.add(If(Or(op[i]==0,op[i]==1,op[i]==2), ULE(a[i],255),
           If(op[i]==3, And(ULE(a[i],31),UGE(a[i],1)),
              And(ULE(a[i],3), a[i]!=d[i]))))  # SWAP/MIX
regs=[BitVecVal(v,32) for v in INIT]
carry=BitVecVal(0,32)
FNVP=BitVecVal(0x01000193,32)
def rol5(x): return RotateLeft(x,5)
prev=BitVecVal(0x811c9dc5,32)
flags=BitVecVal(0,32)
last_ecx=None
for i in range(N):
    o=op[i]; di=d[i]; ai=a[i]
    rd=regsel(regs,di); ra=regsel(regs,ai)
    # candidate new value for the destination register under each op
    movi=(rd & 0xffffff00) | (ai & 0xff)
    addsum=(ZeroExt(0,rd) + (ai & 0xff) + carry)  # 32-bit; carry as 0/1
    addv=addsum & 0xffffffff
    addcarry=If(ULT(addv, rd), BitVecVal(1,32), BitVecVal(0,32))  # overflow if wrapped (a+carry small)
    # more robust carry: use 33-bit
    ext=ZeroExt(1,rd)+ZeroExt(1,ai & 0xff)+ZeroExt(1,carry)
    addv=Extract(31,0,ext); addcarry=ZeroExt(31,Extract(32,32,ext))
    xorv=rd ^ ((ai & 0xff)*0x01010101)
    rolv=rol(rd, ai)
    mixt=rol(rd ^ ra, (ra & 7)+1)
    mixv=(mixt + carry + 0x9E3779B9) & 0xffffffff
    mixcarry=LShR(mixv,31)
    # new destination value
    newd=If(o==0,movi,If(o==1,addv,If(o==2,xorv,If(o==3,rolv,If(o==5,mixv, rd)))))  # SWAP handled below
    newregs=[]
    for j in range(4):
        jj=BitVecVal(j,32)
        base=regs[j]
        # SWAP: reg[d]<->reg[a]
        swapped=If(di==jj, ra, If(ai==jj, rd, base))
        # non-swap ops write only reg[d]
        writ=If(di==jj, newd, base)
        newregs.append(If(o==4, swapped, writ))
    regs=newregs
    carry=If(o==0,BitVecVal(0,32),If(o==1,addcarry,If(o==5,mixcarry,carry)))
    flags=flags | If(o==0,BitVecVal(1,32),If(o==1,BitVecVal(2,32),If(o==2,BitVecVal(4,32),If(o==3,BitVecVal(8,32),If(o==4,BitVecVal(0x10,32),BitVecVal(0x20,32))))))
    # hash
    ob=If(o==0,BitVecVal(OPB[0],32),If(o==1,BitVecVal(OPB[1],32),If(o==2,BitVecVal(OPB[2],32),If(o==3,BitVecVal(OPB[3],32),If(o==4,BitVecVal(OPB[4],32),BitVecVal(OPB[5],32))))))
    c=(ob ^ prev)
    c=c*FNVP; c=rol5(c); c=c ^ (di & 0xff); c=c ^ 0xa5a5a5a5
    c=c*FNVP; c=rol5(c); c=c ^ (ai & 0xff)
    last_ecx=c
    e=c ^ 0xa5a5a5a5; e=e*FNVP; e=rol5(e); e=e ^ 0xa5a5a5a5
    prev=e
# final constraints
for j in range(4): s.add(regs[j]==TARGET[j])
s.add(carry==1)
s.add(flags==0x3f)
s.add(last_ecx==0xdd32fb3)
print("solving..."); t=time.time()
r=s.check()
print(r, "in %.1fs"%(time.time()-t))
if r==sat:
    m=s.model()
    NAMES=['MOVI','ADD','XOR','ROL','SWAP','MIX']
    prog=[]
    for i in range(N):
        oi=m[op[i]].as_long(); di=m[d[i]].as_long(); ai=m[a[i]].as_long()
        prog.append((NAMES[oi],di,ai))
    for i,(o,di,ai) in enumerate(prog):
        if o in ('SWAP','MIX'): print(f"{o} R{di} R{ai}")
        else: print(f"{o} R{di} {ai}")
    import json; open('prog.json','w').write(json.dumps(prog))
