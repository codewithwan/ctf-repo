# NULLSTAR // BREACH 3

**Status:** solved

**Flag:** `0xV0ID{S3cr3t_P4ss!}` (recovered from capture.pcap, verified against pcap — not submitted)

**Technique tags:** forensics, pcap, HTTP basic auth, credential brute

**Signals:** BREACH 3 reuses capture.pcap. The admin console at :8080 is protected by HTTP Basic auth; the attacker "got in by guessing" — so find the login attempts and the one that stops returning 401.

**Method**
- Dump `GET /admin/login` requests (User-Agent `BruteForcer/2.1`) and decode `Authorization: Basic ...`:
  - `admin:admin` -> 401
  - `admin:password` -> 401
  - `admin:letmein` -> 401
  - `admin:admin123` -> 401
  - `admin:root` -> 401
  - `admin:S3cr3t_P4ss!` -> **200** (success)
- Successful attempt is frame 94; response 200 at frame 96, then `POST /admin/upload.php` + `sh3ll.php` RCE follow.

**Verification:** `tshark -e http.authbasic` decodes all six attempts; only `S3cr3t_P4ss!` maps to a 200 response.

**Reusable takeaway:** For Basic-auth brute in a pcap, `http.authbasic` decodes credentials directly; pair each request with the next response code to find which credential succeeded.

## Solve
`solver.py` pairs login attempts with response codes and prints the successful password.
