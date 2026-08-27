# Midnight Trace - 2

**Status:** solved
**Flag:** `0xV01D{ops-jump02}` (recovered from pcap; not submitted)

**Technique tags:** forensics, pcap, intrusion-chain, pivot, dns-discovery

**Signals:** same `midnight_trace.pcap` as Midnight Trace - 1; after the initial
compromise of WEB01 (10.63.20.17), frames 4-9 are DNS discovery:
`dc01.finance.local`, `ops-jump02.finance.local`, `vault01.finance.local`.
Frame 10-11 show WEB01 SSHing to 10.63.30.44 and the reply
`pivot ok hostname=ops-jump02` — the first internal pivot hostname.

## Method
- Unzip `midnight_trace.zip` → `midnight_trace.pcap`.
- Parse frames; the DNS queries after the initial payload (frames 4-9) list the
  discovery targets, and the first TCP connection after discovery (frame 10,
  `10.63.20.17:49822 -> 10.63.30.44:22`) is answered (frame 11) with
  `pivot ok hostname=ops-jump02`.
- `ops-jump02` is the first internal pivot hostname; submit as `0xV01D{ops-jump02}`.

## Solve
`solver.py` prints the pivot hostname and flag.
