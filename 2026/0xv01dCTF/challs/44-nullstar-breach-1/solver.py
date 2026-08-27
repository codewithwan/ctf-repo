#!/usr/bin/env python3
"""NULLSTAR // BREACH 1 — attacker IP from capture.pcap (see NULLSTAR // BREACH).

The single capture from the victim segment shows the whole breach:
port-scan SYN sweep, then exploitation of the open port. The attacker is the
external IP that initiates the first knock and the HTTP exploit traffic.
"""
import ipaddress
import subprocess

PCAP = "../16-nullstar-breach/capture.pcap"


def main():
    out = subprocess.run(
        ["tshark", "-r", PCAP, "-T", "fields",
         "-e", "ip.src", "-e", "tcp.flags.str"],
        capture_output=True, text=True, check=True).stdout

    syn_sources = {}
    for line in out.splitlines():
        parts = line.split("\t")
        if len(parts) != 2:
            continue
        src, flags = parts
        if flags.startswith("·") and "S" in flags.replace("·", ""):
            syn_sources[src] = syn_sources.get(src, 0) + 1

    # attacker = source of SYN opens from outside the victim LAN (192.168.10.0/24)
    lan = ipaddress.ip_network("192.168.10.0/24")
    for src, n in sorted(syn_sources.items(), key=lambda kv: -kv[1]):
        if ipaddress.ip_address(src) not in lan:
            print("attacker IP:", src)
            print("FLAG: 0xV0ID{%s}" % src)
            return
    raise SystemExit("no external SYN source found")


if __name__ == "__main__":
    main()
