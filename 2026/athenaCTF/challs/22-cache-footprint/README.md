# Cache Footprint

- **Category:** FORENSICS
- **Points:** 200
- **Solves:** 15
- **URL:** https://ctf-2026.ctf-platform.xyz/challenges/niku1h9n492wnpoup165r3r0

## Description
A browser cache was carved from a kiosk image after an incident. The exported SQLite database contains browsing history, downloads, cookies, form data, and session storage. The operator cleaned up after themselves, so the download that matters is no longer in the downloads table — but a delete is not an erase. Recover the missing record, work out how its payload was exported, and decode it to recover the flag. **The data URIs still sitting in the database are not the answer.**

## Files (download manual)
- `browser_history.sqlite` — 24 KB → taruh di folder ini

## Instance
Not required

## Hints
- Hint 1: −50 · Hint 2: −50 · Hint 3: −50

## Dugaan
SQLite forensics: record download yang di-DELETE masih ada di **freelist / unallocated pages** (delete ≠ erase). Carve deleted row dari SQLite (freeblocks / WAL), ambil URL/payload download-nya, decode. Data URI di DB = red herring. Gw bisa parse pakai sqlite + carve unallocated. Kirim `browser_history.sqlite`.
