import re,sys
M32=0xffffffff
def sm32(v):
    v&=M32; h=((v>>16)^v)&M32; h=(h*0x7feb352d)&M32; h=((h>>15)^h)&M32
    h=(h*0x846ca68b)&M32; h=((h>>16)^h)&M32; return h
def gcd(a,b):
    while b:a,b=b,a%b
    return a
CH=".:+#"
def enc_block(b,i,key):
    s=[(b>>6)&3,(b>>4)&3,(b>>2)&3,b&3]
    h=sm32((i*0x45d9f3b)&M32 ^ key); ink=h%5; inkv=(h>>8)&3
    blk=[]; si=0
    for pos in range(5):
        if pos==ink: blk.append(inkv)
        else: blk.append(s[si]); si+=1
    if i&1: blk=blk[::-1]
    return "".join(CH[x] for x in blk)

def solve(out, key, L):
    mult=next(p for p in [5,7,11,13,17,19,23,29,31] if gcd(p,L)==1)
    start=(key>>16)%L
    blocks=re.split(r'[|/~]', out)        # split by separators
    blocks=[b for b in blocks if b]        # drop empties
    assert len(blocks)==L, f"got {len(blocks)} blocks, expected {L}: {[len(b) for b in blocks]}"
    flag=bytearray(L)
    for i in range(L):
        p=(start+i*mult)%L
        target=blocks[p]
        found=None
        for b in range(256):
            if enc_block(b,i,key)==target: found=b; break
        flag[i]=found if found is not None else 0x3f
    return bytes(flag)

if __name__=='__main__':
    if len(sys.argv)>=3:
        key=int(sys.argv[1],16); out=sys.argv[2]; L=len(re.split(r'[|/~]',out.strip())) 
        L=len([b for b in re.split(r'[|/~]',out.strip()) if b])
        print(solve(out.strip(),key,L).decode('latin1'))
    else:
        data=open('run1.txt').read()
        out=max((l.strip() for l in data.splitlines() if l.strip() and set(l.strip())<=set('|/~.:+#')),key=len)
        r=solve(out,0x1E02A6B7,42)
        print("decoded :",r)
        print("expected: b'BDSEC{abcdefghijklmnopqrstuvwxyz012345678}'")
        print("MATCH:", r==b"BDSEC{abcdefghijklmnopqrstuvwxyz012345678}")
