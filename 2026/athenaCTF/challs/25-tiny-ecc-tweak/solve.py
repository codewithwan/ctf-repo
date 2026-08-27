import hashlib
from Crypto.Cipher import AES

# secp256k1
p  = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F
n  = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141
Gx = 0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798
Gy = 0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8

def inv(a,m): return pow(a,-1,m)
def add(P,Q):
    if P is None: return Q
    if Q is None: return P
    if P[0]==Q[0] and (P[1]+Q[1])%p==0: return None
    if P==Q:
        l=(3*P[0]*P[0])*inv(2*P[1],p)%p
    else:
        l=(Q[1]-P[1])*inv(Q[0]-P[0],p)%p
    x=(l*l-P[0]-Q[0])%p; y=(l*(P[0]-x)-P[1])%p
    return (x,y)
def mul(k,P):
    R=None
    while k:
        if k&1: R=add(R,P)
        P=add(P,P); k>>=1
    return R

G=(Gx,Gy)
r  = 85648066978054117297931732228825879776919476959248536209880673617777258551576
s1 = 9201749990054392630326738993981507791280139616009590576070734116206809113927
s2 = 8462704732267552867539133466066949384082947748926361554817429665701053787331
msg1=b'public message alpha'
msg2=b'public message beta'
PUB=(0x702468aa105b856bc210955eb43be9ce4a04f4c5e4ea5c2571515e2d3add7223,
     0xbf26618e324947c764ea50b36f3a51a6a0149be0a27ee23942ce7eeb176d09ba)

z1=int.from_bytes(hashlib.sha256(msg1).digest(),'big')%n
z2=int.from_bytes(hashlib.sha256(msg2).digest(),'big')%n

# nonce reuse: k = (z1-z2)/(s1-s2); try both sign combos of k
for kk in [ (z1-z2)*inv((s1-s2)%n,n)%n, (z1-z2)*inv((s2-s1)%n,n)%n ]:
    for k in (kk, (n-kk)%n):
        d=(s1*k - z1)*inv(r,n)%n
        if mul(d,G)==PUB:
            print("[+] private key d =", hex(d))
            print("    k =", hex(k))
            ct=bytes.fromhex('8af0c838f666ff56951dc7a72cc4ebd3cbcc7a08564d9d4a6268ecbc2cd6233ae460fd8fe91a35')
            nonce=bytes.fromhex('429f5788ac9f95a7ff00b71b')
            body,tag=ct[:-16],ct[-16:]
            db=d.to_bytes(32,'big')
            cands={
              'raw d 32B (AES-256)': db,
              'sha256(d bytes)': hashlib.sha256(db).digest(),
              'sha256(str d)': hashlib.sha256(str(d).encode()).digest(),
              'sha256(hex d)': hashlib.sha256(hex(d).encode()).digest(),
              'sha256(hex d no0x)': hashlib.sha256(('%064x'%d).encode()).digest(),
              'd 16B lo (AES-128)': db[16:],
              'd 16B hi (AES-128)': db[:16],
              'sha256(d bytes)[:16]': hashlib.sha256(db).digest()[:16],
            }
            for name,key in cands.items():
                try:
                    c=AES.new(key,AES.MODE_GCM,nonce=nonce)
                    pt=c.decrypt_and_verify(body,tag)
                    print(f"[FLAG] via {name}: {pt}")
                except Exception as e:
                    pass
            raise SystemExit
print("no d matched pubkey")
