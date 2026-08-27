import re
M32=0xffffffff
def sm32(v):
    v&=M32; h=((v>>16)^v)&M32; h=(h*0x7feb352d)&M32; h=((h>>15)^h)&M32
    h=(h*0x846ca68b)&M32; h=((h>>16)^h)&M32; return h
def gcd(a,b):
    while b:a,b=b,a%b
    return a
SYM={'.':0,':':1,'+':2,'#':3}
flag=b"BDSEC{abcdefghijklmnopqrstuvwxyz012345678}"
data=open('run1.txt').read()
out=max((l.strip() for l in data.splitlines() if l.strip() and set(l.strip())<=set('|/~.:+#')),key=len)
key=0x1E02A6B7; L=42
mult=next(p for p in [5,7,11,13,17,19,23,29,31] if gcd(p,L)==1); start=(key>>16)%L
blocks=[b for b in re.split(r'[|/~]',out) if b]
print("nblocks", len(blocks), "block lens", set(len(b) for b in blocks))
for i in range(10):
    p=(start+i*mult)%L
    blk=[SYM[c] for c in blocks[p]]
    b=flag[i]; s=[(b>>6)&3,(b>>4)&3,(b>>2)&3,b&3]
    h=sm32((i*0x45d9f3b)&M32 ^ key); myink=h%5; inkv=(h>>8)&3
    # find which removal gives s or reverse(s)
    res=[]
    for rmpos in range(5):
        rem=blk[:rmpos]+blk[rmpos+1:]
        if rem==s: res.append((rmpos,'fwd'))
        if rem==s[::-1]: res.append((rmpos,'rev'))
    print(f"i={i} parity={i&1} s={s} blk={blk} myink={myink} inkv={inkv} -> match {res}")
