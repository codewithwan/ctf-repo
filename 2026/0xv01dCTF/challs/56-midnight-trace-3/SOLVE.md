# Midnight Trace - 3

**Status:** solved
**Flag:** `0xV01D{0xVOID_nova0x_VAULT01}` (recovered from pcap; not submitted)

**Technique tags:** forensics, pcap, smb, ntlmssp, lateral-movement

**Signals:** same `midnight_trace.pcap`; frame 12 is the first SMB session setup:
`SMB2 SESSION_SETUP NTLMSSP_AUTH Domain=0xVOID User=nova0x Workstation=WEB01
Target=VAULT01 TreeConnect=\\VAULT01\finance$` from ops-jump02 (10.63.30.44)
to VAULT01 (10.63.40.19:445). Flag joins domain_user_host.

## Method
- Parse pcap; grep for `NTLMSSP_AUTH`.
- Frame 12 carries the authenticated identity: Domain=`0xVOID`, User=`nova0x`,
  destination host=`VAULT01`.
- Submit as `domain_user_host` → `0xVOID_nova0x_VAULT01`.

## Solve
`solver.py` prints the SMB auth line and flag.
