# Mailroom Echo — SOLVED

**Flag:** `athena{mime_threads_reveal_the_truth}`

## Langkah
1. Download `mailroom_echo.eml` dari halaman challenge.
2. Ini email MIME `multipart/mixed` dengan 2 part:
   - Part 1 (`text/plain`, body): pengalih perhatian — *"Nothing useful is visible in the body, so check the attached note."*
   - Part 2: attachment `quarterly_summary.txt`, `Content-Transfer-Encoding: base64`.
3. Sesuai hint (*"the interesting part rarely rides in the body"*), fokus ke attachment. Decode base64-nya:

   ```bash
   echo 'UXVhcnRlcmx5...Zm9yd2FyZC4K' | base64 -d
   ```

   Hasil (`quarterly_summary.txt`):
   ```
   Quarterly reconciliation complete.
   Backup marker: athena{mime_threads_reveal_the_truth}
   Do not forward.
   ```

## Catatan
- Difficulty easy, 50 pts, no instance, no hint dipakai.
- File: `mailroom_echo.eml` (asli), `quarterly_summary.txt` (attachment ter-decode).
