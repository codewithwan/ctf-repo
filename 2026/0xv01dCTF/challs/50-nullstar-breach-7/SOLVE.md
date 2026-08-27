# NULLSTAR // BREACH 7 — SOLVED

**Status:** solved

**Flag:** `0xV0ID{t.0xv0id-c2.net}` (recovered from capture.pcap, verified against pcap AND confirmed on platform)

**Technique tags:** forensics, pcap, DNS exfiltration, C2 beaconing

**Signals:** after the exploitation burst, the victim (192.168.10.50) starts issuing DNS queries whose labels look random (`00mnftkqt2`, `01gasdgbaf`, `02ibjwi3bh`, ...) — classic DNS exfil/beaconing pattern ("very strange name lookups").

**Method**
- Enumerate DNS queries: 18 total, 11 of them are `*.<random>.t.0xv0id-c2.net`.
- Normal lookups (ubuntu.com, pool.ntp.org, api.github.com, cdn.jsdelivr.net, mirrors.kernel.org, 0xv0id-app.internal, sync.0xv0id-app.internal) account for the rest.
- The exfil burst targets one fixed suffix: **t.0xv0id-c2.net** (labels `<idx><chunk>.t.0xv0id-c2.net`). The `<idx>` prefix (`00..0a`) is the chunk order for BREACH 8's reassembly.

**Verification:** `tshark -Y "dns.flags.response==0"` + counting by the last three labels: `t.0xv0id-c2.net` appears 11 times, all other domains once/twice. Flag `0xV0ID{t.0xv0id-c2.net}` confirmed accepted on the platform.

**Reusable takeaway:** in DNS-exfil captures, aggregate by the fixed suffix (the leak destination); the random first label is the payload.

## Solve
`solver.py` lists query counts per registrable domain and prints the leak destination.
