M32=0xffffffff
def sm32(v):
    v&=M32; h=((v>>16)^v)&M32; h=(h*0x7feb352d)&M32; h=((h>>15)^h)&M32
    h=(h*0x846ca68b)&M32; h=((h>>16)^h)&M32; return h
SYM={'.':0,':':1,'+':2,'#':3}
flag=b"BDSEC{abcdefghijklmnopqrstuvwxyz012345678}"
data=open('run1.txt').read()
out=max((l.strip() for l in data.splitlines() if l.strip() and set(l.strip())<=set('|/~.:+#')),key=len)
key=0x1E02A6B7; L=42
blocks=[[SYM[c] for c in out[6*k:6*k+5]] for k in range(L)]
def dec(blk,i):
    h=sm32((i*0x45d9f3b)&M32 ^ key); ink=h%5
    pos = ink if (i%2==0) else 4-ink
    s=blk[:pos]+blk[pos+1:]
    return (s[0]<<6)|(s[1]<<4)|(s[2]<<2)|s[3]
# for each i, find p where dec(blocks[p],i)==flag[i]
perm={}
for i in range(L):
    hits=[p for p in range(L) if dec(blocks[p],i)==flag[i]]
    perm[i]=hits
    print(f"i={i:2d} flag={chr(flag[i])!r} -> p candidates {hits}")
# show the clean single-candidate mapping
clean={i:v[0] for i,v in perm.items() if len(v)==1}
print("single-candidate i->p:", clean)
