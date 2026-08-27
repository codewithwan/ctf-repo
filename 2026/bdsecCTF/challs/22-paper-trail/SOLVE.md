# Paper Trail — DFIR (175) [FBBL "Inside Job" series]

**Flag:** `BDSEC{knightsquad4041337@_unknown321@protonmail.com}` · verified "Correct" (challenge id 22)
**Question:** *What is the FirstBangla Bank employee email's password and the attacker's email address?*
Format: `BDSEC{password_email}`

## The chain
1. **Firefox saved login** (arif.khan): `home/arif.khan/snap/firefox/common/.mozilla/firefox/390s6fqa.default/{key4.db,logins.json}`.
   Saved credential for `https://firstbanglamail.com` → user `arif.khan@firstbangla.com`.
2. **Decrypt it** (pure-python NSS, no libnss needed). key4.db here uses the older pre-hash:
   `key = PBKDF2-SHA256( SHA1(globalSalt + masterPassword) , entrySalt, iters, 32)` with an **empty**
   master password (metadata check decrypts to `password-check`); logins are 3DES-CBC with the
   master key from `nssPrivate.a11`.  → password = **`knightsquad4041337@`**.
   (The `notes.txt` "current: Welcome@2024!" is a decoy — that's the *personal* password.)
3. **The password is a LIVE webmail login, not the answer's endpoint.** The Firefox **cache**
   (`cache2/entries`) had a cached "FirstBangla Mail — Secure Webmail" page pointing at
   **`http://50.116.30.77:5000/login`**. Log in there as `arif.khan@firstbangla.com` / `knightsquad4041337@`.
4. **Read the inbox = the paper trail.** Among 761 mails, the attacker thread is from
   **A. Reza `<unknown321@protonmail.com>`** (`Re: wallet`, `Re: travel booked`, `Re: quick question` …)
   — the handler who coordinates the theft and introduces "Rajesh Patel" as his logistics partner.
   → attacker email = **`unknown321@protonmail.com`**.

→ `BDSEC{knightsquad4041337@_unknown321@protonmail.com}`

## The trap that cost 4 attempts
`r.consultant@protonmail.com` (from arif's recovered bash history: `gpg --encrypt --recipient
r.consultant@protonmail.com wallet_backup.txt`, annotated "links to R") is a **red herring** — it's
arif's gpg wallet-laundering contact, NOT the email-compromise attacker. The real attacker email only
appears **inside the webmail inbox**, which requires actually logging in with the decrypted password.
Lesson: a cryptographically-certain credential that "should" be the answer may instead be a **key to a
live service** — follow it in, don't just submit it.

## Solver (Firefox NSS decrypt)
```python
import sqlite3,hashlib,base64,json
from hashlib import pbkdf2_hmac
from pyasn1.codec.der import decoder
from Crypto.Cipher import AES,DES3
gs=sqlite3.connect('key4.db').execute("SELECT item1 FROM metadata WHERE id='password'").fetchone()[0]
def pbes2(d,mp=b''):
    es=d[0][1][0][1][0].asOctets(); it=int(d[0][1][0][1][1]); kl=int(d[0][1][0][1][2])
    key=pbkdf2_hmac('sha256', hashlib.sha1(gs+mp).digest(), es, it, kl)          # SHA1 pre-hash!
    return AES.new(key,AES.MODE_CBC,b'\x04\x0e'+d[0][1][1][1].asOctets()).decrypt(d[1].asOctets())
master=pbes2(decoder.decode(sqlite3.connect('key4.db').execute("SELECT a11 FROM nssPrivate").fetchone()[0])[0])[:24]
def dl(b):
    d=decoder.decode(base64.b64decode(b))[0]; x=DES3.new(master,DES3.MODE_CBC,d[1][1].asOctets()).decrypt(d[2].asOctets()); return x[:-x[-1]]
L=json.load(open('logins.json'))['logins'][0]
print(dl(L['encryptedUsername']), dl(L['encryptedPassword']))   # arif.khan@firstbangla.com  knightsquad4041337@
```

## Reusable takeaways
- Firefox `key4.db` decryption is pure-python: try both SHA1 and SHA256 pre-hash variants (this one was SHA1);
  the metadata `password-check` value tells you when the derivation + master password are right.
- Mine the browser **cache** (`cache2/entries`, strings-grep) — cached pages reveal live hosts, webmail,
  and content that isn't in any obvious file.
- "Paper Trail" = literally read the mailbox. The attacker's address is a live email's `From:`, not the
  most obvious crypto artifact on the disk.
