# NULLSTAR // BREACH 6

**Status:** solved

**Flag:** `0xV0ID{Vau1t_K3y_9f3a}` (recovered from capture.pcap, verified against pcap — not submitted)

**Technique tags:** forensics, pcap, base64, config dump

**Signals:** the RCE chain includes `base64 /opt/app/config.php`; the response "doesn't look like much on the wire" — a base64 blob that decodes to a PHP config carrying a secret (vault) key.

**Method**
- Frame 144: `GET /uploads/sh3ll.php?cmd=base64%20/opt/app/config.php`
- Frame 146 response body (base64) decodes to:
  ```php
  <?php
  $DB_HOST='127.0.0.1';
  $DB_USER='appsvc';
  $DB_PASS='Vau1t_K3y_9f3a';
  $DB_NAME='0xv0id_app';
  // TODO: rotate vault key before audit
  ?>
  ```
- The secret key is `$DB_PASS` = **Vau1t_K3y_9f3a** (comment even labels it "vault key").

**Verification:** decoded PHP config matches the request; key value present verbatim.

**Reusable takeaway:** look for `base64 <file>` webshell commands — the response is double-encoded (HTTP + base64); decode the body to get the plaintext artifact.

## Solve
`solver.py` finds the `base64 /opt/app/config.php` request, base64-decodes the next text/plain response, and extracts `$DB_PASS`.
