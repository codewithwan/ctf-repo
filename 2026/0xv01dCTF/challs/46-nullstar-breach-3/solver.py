#!/usr/bin/env python3
"""NULLSTAR // BREACH 3 — admin console password from capture.pcap (see NULLSTAR // BREACH).

BruteForcer/2.1 tries HTTP Basic auth on /admin/login until one attempt gets
200 (vs 401). tshark's http.authbasic gives the decoded user:pass.
"""
import subprocess
from pathlib import Path

PCAP = str(Path(__file__).resolve().parent / "../16-nullstar-breach/capture.pcap")


def main():
    out = subprocess.run(
        ["tshark", "-r", PCAP, "-Y", "http.request && http.request.uri==\"/admin/login\"",
         "-T", "fields", "-e", "frame.number", "-e", "http.authbasic"],
        capture_output=True, text=True, check=True).stdout

    attempts = []
    for line in out.splitlines():
        parts = line.split("\t")
        if len(parts) == 2:
            attempts.append((int(parts[0]), parts[1]))

    out2 = subprocess.run(
        ["tshark", "-r", PCAP, "-Y", "http.response", "-T", "fields",
         "-e", "frame.number", "-e", "http.response.code"],
        capture_output=True, text=True, check=True).stdout
    codes = [(int(a), b) for a, b in (l.split("\t") for l in out2.splitlines())]

    for fnum, creds in attempts:
        code = next((c for fn, c in codes if fn > fnum), None)
        user, pw = creds.split(":", 1)
        status = "OK" if code == "200" else "fail"
        print(f"frame {fnum}: {creds} -> {code} {status}")
        if code == "200":
            print("FLAG: 0xV0ID{%s}" % pw)
            return


if __name__ == "__main__":
    main()
