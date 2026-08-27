import sqlite3, hashlib
from hashlib import pbkdf2_hmac
from pyasn1.codec.der import decoder
from Crypto.Cipher import AES
con=sqlite3.connect('ffprofile/key4.db'); cur=con.cursor()
cur.execute("SELECT item1,item2 FROM metadata WHERE id='password'")
gs,item2=cur.fetchone()
print("globalSalt:", gs.hex(), "len", len(gs))
d=decoder.decode(item2)[0]
es=d[0][1][0][1][0].asOctets(); it=int(d[0][1][0][1][1]); kl=int(d[0][1][0][1][2])
iv=b'\x04\x0e'+d[0][1][1][1].asOctets(); enc=d[1].asOctets()
def dec(key): return AES.new(key,AES.MODE_CBC,iv).decrypt(enc)
variants={
 'sha256(gs+mp)': lambda mp: pbkdf2_hmac('sha256',hashlib.sha256(gs+mp).digest(),es,it,kl),
 'gs+mp direct' : lambda mp: pbkdf2_hmac('sha256',gs+mp,es,it,kl),
 'sha1(gs+mp)'  : lambda mp: pbkdf2_hmac('sha256',hashlib.sha1(gs+mp).digest(),es,it,kl),
 'mp only'      : lambda mp: pbkdf2_hmac('sha256',mp if mp else b'\x00'*0,es,it,kl),
}
for name,f in variants.items():
    try:
        pt=dec(f(b''))
        print(f"[{name}] empty -> {pt!r}")
    except Exception as e: print(name,'err',e)
