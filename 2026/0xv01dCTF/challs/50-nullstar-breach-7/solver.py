#!/usr/bin/env python3
"""NULLSTAR // BREACH 7 — C2/exfil domain from capture.pcap (see NULLSTAR // BREACH).

After the breach, the victim issues a burst of DNS queries with random
subdomain labels (classic DNS beaconing/exfil). The shared registrable
domain is the leak destination.
"""
from collections import Counter
import subprocess
from pathlib import Path

PCAP = str(Path(__file__).resolve().parent / "../16-nullstar-breach/capture.pcap")


def reg_domain(name):
    """strip the random subdomain label, keep 2LD (eTLD+1 approximation)."""
    labels = name.split(".")
    return ".".join(labels[-2:]) if len(labels) >= 2 else name


def exfil_domain(name):
    """keep the fixed suffix *.t.0xv0id-c2.net (the leak destination)."""
    labels = name.split(".")
    return ".".join(labels[-3:]) if len(labels) >= 3 else name


def main():
    out = subprocess.run(
        ["tshark", "-r", PCAP, "-Y", "dns.flags.response==0",
         "-T", "fields", "-e", "dns.qry.name"],
        capture_output=True, text=True, check=True).stdout
    queries = [q for q in out.split() if q]
    c = Counter(exfil_domain(q) for q in queries)
    for dom, n in c.most_common():
        print(f"{n:3d}  {dom}")
    top = c.most_common(1)[0][0]
    print("FLAG: 0xV0ID{%s}" % top)


if __name__ == "__main__":
    main()
