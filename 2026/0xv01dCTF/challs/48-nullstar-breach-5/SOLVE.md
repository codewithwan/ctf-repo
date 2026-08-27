# NULLSTAR // BREACH 5

**Status:** solved

**Flag:** `0xV0ID{secrets.kdbx}` (recovered from capture.pcap, verified against pcap — not submitted)

**Technique tags:** forensics, pcap, RCE output, filesystem enumeration

**Signals:** the webshell RCE chain includes `ls -la /root`; the response body contains the directory listing of root's home — the "protected file" is the root-only entry.

**Method**
- Frame 136 response to `GET /uploads/sh3ll.php?cmd=ls%20-la%20/root`:
  - `-rw-------  1 root root 8192 Apr 11 02:13 secrets.kdbx`
- `secrets.kdbx` is a KeePass vault: mode 0600 (root-only), non-dir — the only protected file in `/root` (other entries are `.` and `..`).

**Verification:** only one regular file appears in the /root listing; it is the only one with root-only permissions.

**Bonus context:** the following request leaks `/opt/app/config.php` (base64): `$DB_HOST='127.0.0.1'; $DB_USER='appsvc'; $DB_PASS='Vau1t_K3y_9f3a'; $DB_NAME='0xv0id_app'; // TODO: rotate vault key before audit` — likely material for later BREACH stages.

**Reusable takeaway:** when a webshell is used, every `?cmd=` response is stored in the pcap as HTTP text/plain — read them in order to reconstruct the whole post-exploitation story.

## Solve
`solver.py` finds the `ls -la /root` request, takes the next text/plain response, and extracts the root-owned file name.
