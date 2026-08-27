M32=0xffffffff
def sm32(v):
    v&=M32
    h=((v>>16)^v)&M32; h=(h*0x7feb352d)&M32; h=((h>>15)^h)&M32
    h=(h*0x846ca68b)&M32; h=((h>>16)^h)&M32; return h
SYM={'.':0,':':1,'+':2,'#':3}
flag=b"BDSEC{abcdefghijklmnopqrstuvwxyz012345678}"
data=open('run1.txt').read()
out=max((l.strip() for l in data.splitlines() if l.strip() and set(l.strip())<=set('|/~.:+#')),key=len)
key=0x1E02A6B7; L=42; mult=5; start=38
blocks=[out[6*k:6*k+5] for k in range(L)]
for i in range(7):
    p=(start+i*mult)%L
    b=flag[i]
    exp=[(b>>6)&3,(b>>4)&3,(b>>2)&3,b&3]
    h=sm32((i*0x45d9f3b)&M32 ^ key); ink=h%5; inksym=(h>>8)&3
    raw=[SYM[c] for c in blocks[p]]
    rev=raw[::-1]
    print(f"i={i} b={chr(b)}={b:08b} exp_syms={exp} inkpos={ink} inksym={inksym}")
    print(f"     block[p={p}]={blocks[p]} raw={raw} rev={rev}")
