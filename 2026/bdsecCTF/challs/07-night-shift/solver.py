from itertools import product
M=0xffffffff
def rol(x,n): n&=31; return ((x<<n)|(x>>(32-n)))&M if n else x&M
def ror(x,n): n&=31; return ((x>>n)|(x<<(32-n)))&M if n else x&M
def mix32(x):
    x&=M; x^=x>>16; x=(x*0x7feb352d)&M; x^=x>>15; x=(x*0x846ca68b)&M; x^=x>>16; return x&M
TARGET=[0x9c8a97dc,0x75a2cc72,0x1d87ef0f,0x4969e73d]
FNV0=0x811c9dc5
def step(regs,FNV,idx,v):
    a,b,c,d=regs
    H=mix32((((idx+1)*0x9e3779b9)&M) ^ ((v*0x45d9f3b)&M))
    if v==0:
        na=rol(a^H,(idx+3)&31); nc=((b^0x13579bdf)+c+idx)&M; a,c=na,nc
    elif v==1:
        nb=rol((b+d+H)&M,5); nd=(d^rol(a,9))&M; b,d=nb,nd
    elif v==2:
        na=(a+idx+0x6d2b79f5)&M; nc=rol((c^b^H)&M,13); a,c=na,nc
    elif v==3:
        nd=mix32((H+d+a)&M); nb=(((idx*17)^b)^0xc001d00d)&M; b,d=nb,nd
    elif v==4:
        na=rol((H+d)&M,7)^a; nb=(b+rol(c,3))&M; nc=(c^rol(a,11))&M; nd=(d+idx+0xa5a5a5a5)&M
        a,b,c,d=na&M,nb,nc,nd
    a&=M;b&=M;c&=M;d&=M
    # epilogue -> FNV
    b_=rol(b,5); ecx=(((v<<24)^idx^a))&M; b_^=ecx
    c_=(rol(c,11)^b_)&M; d_=(ror(d,15)^c_)&M
    o=mix32(d_)
    esi2=(((v<<8)^FNV^idx))&M; ecx2=(o^esi2)&M; ecx2=(ecx2*0x1000193)&M; ecx2=rol(ecx2,7); ecx2^=0xa53c9e17
    return [a,b,c,d], ecx2&M
def run(inp):
    regs=[0,0,0,0]; FNV=FNV0
    for idx in range(8):
        regs,FNV=step(regs,FNV,idx,inp[idx])
    return regs,FNV
sols=[]
for inp in product(range(5),repeat=8):
    regs,FNV=run(inp)
    if regs==TARGET and FNV==0x4455cee8:
        sols.append(inp); 
        print("SOLUTION:", ' '.join(map(str,inp)))
print("total solutions:", len(sols))
if sols: open('sol.txt','w').write(' '.join(map(str,sols[0]))+'\n')
