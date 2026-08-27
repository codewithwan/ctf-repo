import sqlite3, hashlib, base64, json
from hashlib import pbkdf2_hmac
from pyasn1.codec.der import decoder
from Crypto.Cipher import AES, DES3

def unpad(b): 
    return b[:-b[-1]] if b else b

con=sqlite3.connect('ffprofile/key4.db'); cur=con.cursor()
cur.execute("SELECT item1,item2 FROM metadata WHERE id='password'")
globalSalt,item2=cur.fetchone()

def decrypt_pbes2(dec, gsalt, mp=b''):
    entrySalt = dec[0][1][0][1][0].asOctets()
    iters     = int(dec[0][1][0][1][1])
    keylen    = int(dec[0][1][0][1][2])
    k  = hashlib.sha256(gsalt + mp).digest()
    key= pbkdf2_hmac('sha256', k, entrySalt, iters, keylen)
    iv = b'\x04\x0e' + dec[0][1][1][1].asOctets()
    return AES.new(key, AES.MODE_CBC, iv).decrypt(dec[1].asOctets())

# verify empty master password
dec_item2 = decoder.decode(item2)[0]
chk = decrypt_pbes2(dec_item2, globalSalt)
print("password-check:", chk[:16], "(empty master pw OK)" if b'password-check' in chk else "(FAIL)")

# master 3DES key from nssPrivate
cur.execute("SELECT a11 FROM nssPrivate WHERE a102=?", (bytes.fromhex('f8000000000000000000000000000001'),))
row=cur.fetchone()
if not row:
    cur.execute("SELECT a11 FROM nssPrivate"); row=cur.fetchone()
a11=row[0]
dec_a11=decoder.decode(a11)[0]
master=decrypt_pbes2(dec_a11, globalSalt)[:24]
print("master key len:", len(master))

def dec_login(b64):
    d=decoder.decode(base64.b64decode(b64))[0]
    iv=d[1][1].asOctets(); ct=d[2].asOctets()
    return unpad(DES3.new(master, DES3.MODE_CBC, iv).decrypt(ct)).decode('utf-8','replace')

L=json.load(open('ffprofile/logins.json'))['logins'][0]
print("host    :", L['hostname'])
print("username:", dec_login(L['encryptedUsername']))
print("password:", dec_login(L['encryptedPassword']))
