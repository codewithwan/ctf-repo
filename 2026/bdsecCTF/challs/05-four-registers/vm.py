# Reference emulator for the Four Registers VM (little-endian dwords).
MASK=0xffffffff
INIT=[0x13579bdf,0x2468ace0,0x0badf00d,0xc001d00d]
TARGET=[0xd0f7f5a4,0x71d63782,0x2c458dac,0x8c64de6c]
OPB={'MOVI':0x13,'ADD':0x27,'XOR':0x39,'ROL':0x4b,'SWAP':0x5d,'MIX':0x6f}
def rol(x,n): n&=31; return ((x<<n)|(x>>(32-n)))&MASK if n else x&MASK
def run(prog):
    r=INIT[:]; carry=0; flags=0
    for (op,d,a) in prog:
        if op=='MOVI': r[d]=(r[d]&0xffffff00)|(a&0xff); carry=0; flags|=1
        elif op=='ADD': s=r[d]+ (a&0xff)+carry; r[d]=s&MASK; carry=1 if s>>32 else 0; flags|=2
        elif op=='XOR': r[d]^=(a&0xff)*0x01010101; r[d]&=MASK; flags|=4
        elif op=='ROL': r[d]=rol(r[d],a); flags|=8
        elif op=='SWAP': r[d],r[a]=r[a],r[d]; flags|=0x10
        elif op=='MIX':
            t=rol(r[d]^r[a], (r[a]&7)+1); v=(t+carry+0x9E3779B9)&MASK; r[d]=v; carry=(v>>31)&1; flags|=0x20
    return r,carry,flags
def fnv(prog):
    prev=0x811c9dc5
    def rol5(x): return ((x<<5)|(x>>27))&MASK
    ecx=0
    for (op,d,a) in prog:
        c=(OPB[op]^prev)&MASK
        c=(c*0x01000193)&MASK; c=rol5(c); c^=d; c&=MASK; c^=0xa5a5a5a5
        c=(c*0x01000193)&MASK; c=rol5(c); c^=(a&0xff); c&=MASK
        ecx=c
        e=c^0xa5a5a5a5; e=(e*0x01000193)&MASK; e=rol5(e); e^=0xa5a5a5a5
        prev=e&MASK
    return ecx
def check(prog):
    r,carry,flags=run(prog); h=fnv(prog)
    return (r==TARGET, carry==1, flags==0x3f, h==0xdd32fb3, r,carry,flags,hex(h))
if __name__=='__main__':
    # sanity: empty-ish
    print(check([('MOVI',0,0x41)]))
