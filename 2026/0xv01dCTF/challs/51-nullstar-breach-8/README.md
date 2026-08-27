# NULLSTAR // BREACH 8

- **Category:** Forensics
- **Source:** https://0xv01d-ctf.xyz/challenges/108 (same capture as BREACH 1–7)
- **Solves:** 2

## Description
Put it together. The intruder's real prize left the network the same quiet way
those strange lookups did — scattered, wrapped, and locked with something you
already recovered earlier in this capture. Reassemble it and read the message.
The flag is the decoded message itself.

## Files
- `capture.pcap` (in `../16-nullstar-breach/`)

## Solve
`solver.py` reassembles the DNS chunks and prints the flag.
