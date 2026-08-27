#!/usr/bin/env python3
"""NULLSTAR // BREACH 8 — reassemble DNS-exfiltrated prize from capture.pcap.

Scattered: 11 DNS A-queries `XX<base32>.t.0xv0id-c2.net`, XX = hex chunk index.
Wrapped:   base32 payload (charset [a-z2-7], 8 chars/chunk = 5 bytes).
Locked:    repeating-key XOR with S3cr3t_P4ss! (BREACH 3 admin password).

Flag = decoded message itself.
"""
import base64
import subprocess
from pathlib import Path

PCAP = str(Path(__file__).resolve().parent / "../16-nullstar-breach/capture.pcap")
KEY = b"S3cr3t_P4ss!"  # recovered in BREACH 3 (admin console password)


def main():
    out = subprocess.run(
        ["tshark", "-r", PCAP, "-Y",
         "dns.flags.response==0 && dns.qry.name contains \".t.0xv0id-c2.net\"",
         "-T", "fields", "-e", "dns.qry.name"],
        capture_output=True, text=True, check=True).stdout
    chunks = {}
    for q in out.split():
        label = q.split(".", 1)[0]          # e.g. 00mnftkqt2
        idx = int(label[:2], 16)            # hex chunk index 00..0a
        chunks[idx] = label[2:]             # base32 payload
    b32 = "".join(chunks[i] for i in sorted(chunks))
    raw = base64.b32decode(b32.upper() + "=" * ((8 - len(b32) % 8) % 8))
    pt = bytes(c ^ KEY[i % len(KEY)] for i, c in enumerate(raw))
    print(pt.decode())


if __name__ == "__main__":
    main()
