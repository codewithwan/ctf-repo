#!/usr/bin/env python3
"""NULLSTAR // BREACH 4 — uploaded tool filename from capture.pcap (see NULLSTAR // BREACH).

After the successful admin login, the attacker POSTs a PHP webshell to
/admin/upload.php, then calls it under /uploads/. Extract the multipart
filename="..." value.
"""
import re
import subprocess
from pathlib import Path

PCAP = str(Path(__file__).resolve().parent / "../16-nullstar-breach/capture.pcap")


def main():
    out = subprocess.run(
        ["tshark", "-r", PCAP, "-Y", "http.request.method==POST",
         "-T", "fields", "-e", "tcp.payload"],
        capture_output=True, text=True, check=True).stdout
    for hexblob in out.split():
        body = bytes.fromhex(hexblob).decode("utf-8", "replace")
        m = re.search(r'filename="([^"]+)"', body)
        if m:
            print("uploaded filename:", m.group(1))
            print("webshell body:", body.split("\r\n\r\n", 1)[-1].strip())
            print("FLAG: 0xV0ID{%s}" % m.group(1))
            return
    raise SystemExit("no upload found")


if __name__ == "__main__":
    main()
