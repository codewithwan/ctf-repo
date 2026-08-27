import sqlite3, hashlib, base64, json
from hashlib import pbkdf2_hmac
from pyasn1.codec.der import decoder
from Crypto.Cipher import AES, DES3
con=sqlite3.connect('ffprofile/key4.db'); cur=con.cursor()
cur.execute("SELECT item1,item2 FROM metadata WHERE id='password'")
gs,_=cur.fetchone()
def pbes2(dec, mp=b''):
    es=dec[0][1][0][1][0].asOctets(); it=int(dec[0][1][0][1][1]); kl=int(dec[0][1][0][1][2])
    key=pbkdf2_hmac('sha256', hashlib.sha1(gs+mp).digest(), es, it, kl)
    iv=b'\x04\x0e'+dec[0][1][1][1].asOctets()
    return AES.new(key,AES.MODE_CBC,iv).decrypt(dec[1].asOctets())
cur.execute("SELECT a11 FROM nssPrivate WHERE a102=?", (bytes.fromhex('f8000000000000000000000000000001'),))
r=cur.fetchone() or cur.execute("SELECT a11 FROM nssPrivate").fetchone()
master=pbes2(decoder.decode(r[0])[0])[:24]
def unpad(b): return b[:-b[-1]]
def dl(b64):
    d=decoder.decode(base64.b64decode(b64))[0]
    return unpad(DES3.new(master,DES3.MODE_CBC,d[1][1].asOctets()).decrypt(d[2].asOctets())).decode()
L=json.load(open('ffprofile/logins.json'))['logins'][0]
print("host    :", L['hostname'])
print("username:", dl(L['encryptedUsername']))
print("password:", dl(L['encryptedPassword']))
