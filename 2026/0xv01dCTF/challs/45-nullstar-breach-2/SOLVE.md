# NULLSTAR // BREACH 2

**Status:** solved

**Flag:** `0xV0ID{8080}` (recovered from capture.pcap, verified against pcap — not submitted)

**Technique tags:** forensics, pcap, port-scan analysis, attack attribution

**Signals:** BREACH 2 has no own attachment; like BREACH 1 it reuses capture.pcap from the NULLSTAR // BREACH folder (id 108). The description says the attacker found "more than one port open" but only pursued one — so: which ports answer SYN-ACK, and which one actually carries application-layer attack traffic?

**Method**
- SYN sweep by 10.13.37.101 hits 14 ports (21, 22, 23, 25, 53, 80, 110, 143, 443, 445, 3306, 3389, 8080, 8443) against 192.168.10.50.
- Only two reply SYN-ACK: **22** and **8080** (open).
- Port 22: attacker sends RST immediately after SYN-ACK — 3 frames total, no SSH handshake, never pursued.
- Port 8080: full exploitation chain — GET `/`, repeated GET `/admin/login` (credential brute), POST `/admin/upload.php`, then GET `/uploads/sh3ll.php?cmd=...` (RCE: `id`, `/etc/passwd`, `/root`, `config.php`).

**Verification:** `tshark -Y "tcp.flags.syn==1 && tcp.flags.ack==1" -e tcp.srcport` → `[22, 8080]`; all HTTP requests target `192.168.10.50:8080`.

**Reusable takeaway:** "Port found open" != "port attacked". Distinguish scan-only probes (SYN → SYN-ACK → RST, no payload) from real sessions (application-layer payloads after handshake).

## Solve
`solver.py` lists SYN-ACK open ports and the HTTP request log, prints `0xV0ID{8080}`.
