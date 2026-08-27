import sqlite3, hashlib, base64, json
from hashlib import pbkdf2_hmac
from pyasn1.codec.der import decoder
from Crypto.Cipher import AES, DES3

con=sqlite3.connect('ffprofile/key4.db'); cur=con.cursor()
cur.execute("SELECT item1,item2 FROM metadata WHERE id='password'")
globalSalt,item2=cur.fetchone()
d=decoder.decode(item2)[0]
print("outer len", len(d))
print("algo OID:", d[0][0].prettyPrint())
try:
    print("kdf OID :", d[0][1][0][0].prettyPrint())
    print("entrySalt:", d[0][1][0][1][0].asOctets().hex())
    print("iters   :", int(d[0][1][0][1][1]))
    print("keylen  :", int(d[0][1][0][1][2]))
    print("enc OID :", d[0][1][1][0].prettyPrint())
    print("iv14    :", d[0][1][1][1].asOctets().hex(), "len", len(d[0][1][1][1].asOctets()))
except Exception as e: print("struct err", e)

def try_mp(mp):
    entrySalt=d[0][1][0][1][0].asOctets(); iters=int(d[0][1][0][1][1]); keylen=int(d[0][1][0][1][2])
    k=hashlib.sha256(globalSalt+mp).digest()
    key=pbkdf2_hmac('sha256',k,entrySalt,iters,keylen)
    iv=b'\x04\x0e'+d[0][1][1][1].asOctets()
    pt=AES.new(key,AES.MODE_CBC,iv).decrypt(d[1].asOctets())
    return pt
for mp in [b'', b'Welcome@2024!', b'F!rstB@ngla#Vault2024']:
    pt=try_mp(mp)
    ok=b'password-check' in pt
    print(f"mp={mp!r:30} -> {'MATCH' if ok else 'no '} {pt[:20]!r}")
