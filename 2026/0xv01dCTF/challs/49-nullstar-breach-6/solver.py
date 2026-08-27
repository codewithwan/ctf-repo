#!/usr/bin/env python3
"""NULLSTAR // BREACH 6 — secret key from dumped app config (see NULLSTAR // BREACH).

The webshell runs `base64 /opt/app/config.php`; the response body is a
base64 blob that decodes to a PHP config with a "vault key".
"""
import base64
import re
import subprocess
from pathlib import Path

PCAP = str(Path(__file__).resolve().parent / "../16-nullstar-breach/capture.pcap")


def main():
    out = subprocess.run(
        ["tshark", "-r", PCAP, "-Y", 'http.request.uri contains "base64%20"',
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
            resp = bytes.fromhex(hexblob).decode("utf-8", "replace")
            b64 = re.search(r"\r\n\r\n([A-Za-z0-9+/=]+)\s*$", resp)
            if b64:
                cfg = base64.b64decode(b64.group(1)).decode("utf-8", "replace")
                print(cfg)
                m = re.search(r"\$DB_PASS\s*=\s*'([^']+)'", cfg)
                if m:
                    print("FLAG: 0xV0ID{%s}" % m.group(1))
                    return
    raise SystemExit("config dump not found")


if __name__ == "__main__":
    main()
