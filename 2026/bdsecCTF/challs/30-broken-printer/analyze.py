import re
flag = "BDSEC{abcdefghijklmnopqrstuvwxyz012345678}"
key  = 0x1E02A6B7
data = open('run1.txt').read()
# extract scrambled output line (the long .:+# line)
out = [l.strip() for l in data.splitlines() if l.strip() and set(l.strip()) <= set('|/~.:+#')]
out = max(out, key=len)
print("out len:", len(out), "expected 42*6-1 =", 42*6-1)
L=42
# permutation params
def gcd(a,b):
    while b: a,b=b,a%b
    return a
mult=next(p for p in [5,7,11,13,17,19,23,29,31] if gcd(p,L)==1)
start=(key>>16)%L
print("mult",mult,"start",start)
# blocks: every 6 chars -> first 5 are the block, 6th is separator
blocks=[out[6*k:6*k+5] for k in range(L)]
print("block0:", blocks[0], " nblocks:", len(blocks))
SYM={'.':0,':':1,'+':2,'#':3}
# For flag index i, output block position p=(start+i*mult)%L
# Try to decode block -> byte and match flag[i]
for i in range(6):
    p=(start+i*mult)%L
    blk=blocks[p]
    print(f"i={i:2d} flag={flag[i]!r}({ord(flag[i]):02x}={ord(flag[i]):08b}) p={p:2d} blk={blk!r} syms={[SYM.get(c,'?') for c in blk]}")
