# Upload Lantern

- **Category:** INFRA
- **Points:** 350
- **Solves:** 3 (hard!)
- **URL:** https://ctf-2026.ctf-platform.xyz/challenges/mjw2lrwj4fae3qh7a5jvm2tq

## Description
A file upload feature was exported from a staging branch after a sanitization change. A live instance of the staging service is provided: preview stored uploads via `GET /view?name=`. Get the flag.

## Files (download manual)
- `upload_handler.py` — 1.3 KB
- `sanitizer.py` — 925 B
- `config.py` — 581 B
- `tree.txt` — 296 B
- `README.md` — 1.1 KB
→ semua taruh di folder ini

## Instance
**Required** — klik "Create Instance", terus kasih gw `host:port` (atau URL). Endpoint: `GET /view?name=<...>`.

## Hints
- Hint 1: −75 · Hint 2: −100 · Hint 3: −125

## Dugaan
Path traversal / LFI di `GET /view?name=` (sanitizer yang baru diubah = bug baru). Baca `sanitizer.py` buat cari bypass (mis. `....//`, encoding, null byte, absolute path) → baca file flag di server. Kirim ke-5 file + spin up instance, gw garap.
