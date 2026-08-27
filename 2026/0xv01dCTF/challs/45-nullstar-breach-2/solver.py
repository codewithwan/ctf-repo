#!/usr/bin/env python3
"""NULLSTAR // BREACH 2 — attacked TCP port from capture.pcap (see NULLSTAR // BREACH).

The attacker SYN-sweeps 14 ports against 192.168.10.50; only two answer
SYN-ACK (22, 8080). Port 22 gets an immediate RST (scan-only), while 8080
carries the real exploitation: admin-login brute, upload.php, sh3ll.php RCE.
"""
import subprocess
from pathlib import Path

PCAP = str(Path(__file__).resolve().parent / "../16-nullstar-breach/capture.pcap")


def main():
    # open ports = SYN-ACK responses from the victim
    out = subprocess.run(
        ["tshark", "-r", PCAP, "-Y", "tcp.flags.syn==1 && tcp.flags.ack==1",
         "-T", "fields", "-e", "tcp.srcport"],
        capture_output=True, text=True, check=True).stdout
    open_ports = sorted({int(p) for p in out.split() if p.isdigit()})
    print("open ports (SYN-ACK):", open_ports)

    # attacked port = one with payload traffic after the handshake
    out2 = subprocess.run(
        ["tshark", "-r", PCAP, "-Y", "http.request",
         "-T", "fields", "-e", "http.request.method", "-e", "http.host",
         "-e", "http.request.uri"],
        capture_output=True, text=True, check=True).stdout
    print("HTTP exploitation on:")
    for line in out2.splitlines():
        print("  ", line)

    attacked = 8080  # only non-scan conversation with app-layer traffic
    print("FLAG: 0xV0ID{%d}" % attacked)


if __name__ == "__main__":
    main()
