# Midnight Trace - 4

**Status:** solved
**Flag:** `0xV01D{night_shift_ledger_0816.7z}` (recovered from pcap; not submitted)

**Technique tags:** forensics, pcap, smb, exfiltration, staging

**Signals:** same `midnight_trace.pcap`; frame 14 SMB2 CREATE
`file=\\VAULT01\finance$\night_shift_ledger_0816.7z`, frame 15 SMB2 WRITE
(18874368 bytes) stage the archive on VAULT01; frames 16-21 are DNS for the
relay; frames 22-23 open the outbound relay connection to
203.0.113.144:8080 with JSON `"archive":"night_shift_ledger_0816.7z"`.

## Method
- Parse pcap; locate the SMB2 CREATE for the staged archive (frame 14) and the
  outbound relay POST (frame 23), which confirms the archive name in JSON.
- Archive = `night_shift_ledger_0816.7z`.

## Solve
`solver.py` prints the SMB create line and flag.
