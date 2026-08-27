#!/usr/bin/env python3
"""NULLSTAR // BREACH 5 — protected file in /root from capture.pcap (see NULLSTAR // BREACH).

The RCE shell runs `ls -la /root`; the directory listing shows one
root-only file, a KeePass vault.
"""
import subprocess
from pathlib import Path

PCAP = str(Path(__file__).resolve().parent / "../16-nullstar-breach/capture.pcap")


def main():
    out = subprocess.run(
        ["tshark", "-r", PCAP, "-Y", 'http.request.uri contains "ls%20-la%20/root"',
         "-T", "fields", "-e", "frame.number"],
        capture_output=True, text=True, check=True).stdout
    req_frame = int(out.splitlines()[0])

    out2 = subprocess.run(
        ["tshark", "-r", PCAP, "-Y", "http.response && http.content_type==\"text/plain\"",
         "-T", "fields", "-e", "frame.number", "-e", "tcp.payload"],
        capture_output=True, text=True, check=True).stdout
    for line in out2.splitlines():
        fnum, hexblob = line.split("\t", 1)
        if int(fnum) > req_frame:
            body = bytes.fromhex(hexblob).decode("utf-8", "replace")
            if "root" in body and "drwx" in body:
                for row in body.splitlines():
                    if row.startswith("-") and "root root" in row:
                        fname = row.split()[-1]
                        print(row)
                        print("FLAG: 0xV0ID{%s}" % fname)
                        return
    raise SystemExit("listing not found")


if __name__ == "__main__":
    main()
