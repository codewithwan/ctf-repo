import sys
M32=0xffffffff
def sm32(v):
    v&=M32
    h=((v>>16)^v)&M32
    h=(h*0x7feb352d)&M32
    h=((h>>15)^h)&M32
    h=(h*0x846ca68b)&M32
    h=((h>>16)^h)&M32
    return h
def gcd(a,b):
    while b:a,b=b,a%b
    return a
SYM={'.':0,':':1,'+':2,'#':3}
def decode(out, key, L):
    mult=next(p for p in [5,7,11,13,17,19,23,29,31] if gcd(p,L)==1)
    start=(key>>16)%L
    blocks=[out[6*k:6*k+5] for k in range(L)]
    flag=[None]*L
    for i in range(L):
        p=(start+i*mult)%L
        blk=list(blocks[p])
        if i&1:                      # odd index -> block was reversed
            blk=blk[::-1]
        h=sm32((i*0x45d9f3b)&M32 ^ key)
        ink=h%5
        del blk[ink]                 # remove foreign-ink symbol
        s=[SYM.get(c,0) for c in blk]
        b=(s[0]<<6)|(s[1]<<4)|(s[2]<<2)|s[3]
        flag[i]=b
    return bytes(flag)

# verify against known run
data=open('run1.txt').read()
out=max((l.strip() for l in data.splitlines() if l.strip() and set(l.strip())<=set('|/~.:+#')),key=len)
key=0x1E02A6B7; L=42
res=decode(out,key,L)
print("decoded:", res)
print("expected:", b"BDSEC{abcdefghijklmnopqrstuvwxyz012345678}")
print("MATCH:", res==b"BDSEC{abcdefghijklmnopqrstuvwxyz012345678}")
