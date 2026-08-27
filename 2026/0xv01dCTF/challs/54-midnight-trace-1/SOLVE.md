# Midnight Trace - 1

**Status:** solved
**Flag:** `0xV01D{198.51.100.73_WEB01_invoice_0816.lnk}` (recovered from pcap, not submitted)

**Technique tags:** forensics, pcap, intrusion-chain, ssh, payload-triage
**Signals:** tiny synthetic pcap (26 frames) narrating the chain as TCP payload text: external SSH from 198.51.100.73 (TEST-NET-2) to 10.63.20.17:22 runs `cmd.exe /c start invoice_0816.lnk`; server reply names the host and payload: `host=WEB01 payload=invoice_0816.lnk result=opened`.
**Verification:** frame 1 banner + frame 2 command (external IP 198.51.100.73, payload invoice_0816.lnk) + frame 3 host attribution (WEB01); later frames show the pivot (ops-jump02) and exfil (203.0.113.144) — not part of the asked triple.

## Method
- Unzip `midnight_trace.zip` → `midnight_trace.pcap`.
- Dump per-frame IP/port/TCP-payload with a minimal parser (or tshark).
- Frame 2 is the first command executed by the external source: `cmd=cmd.exe /c start invoice_0816.lnk`.
- Frame 3 maps the internal victim: `host=WEB01`.
- Submit as `ip_HOST_payload` → `198.51.100.73_WEB01_invoice_0816.lnk`.

## Solve
`solver.py` parses the pcap and prints the triple.
