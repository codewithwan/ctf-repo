#!/usr/bin/env python3
"""Two Sides of Midnight — tap-ingress vs tap-egress payload XOR.

The inline appliance modified one binary upload while preserving TCP seq space.
For the modified flow the same segment (same flow+seq) carries different bytes
at each tap; XORing the two observations per segment reconstructs the true
file (a ZIP) that exists on neither side alone.
"""
import io
import subprocess
import sys
import zipfile
from collections import defaultdict

PCAP = "two-sides-of-midnight.pcapng"


def dump():
    out = subprocess.run(
        ["tshark", "-r", PCAP, "-T", "fields",
         "-e", "frame.interface_id", "-e", "ip.src", "-e", "tcp.srcport",
         "-e", "ip.dst", "-e", "tcp.dstport", "-e", "tcp.seq", "-e", "tcp.payload",
         "-E", "separator=,"],
        capture_output=True, text=True, check=True).stdout
    rows = []
    for line in out.splitlines():
        f = line.split(",")
        if len(f) != 7 or not f[6]:
            continue
        rows.append((int(f[0]), f[1], int(f[2]), f[3], int(f[4]), int(f[5]),
                     bytes.fromhex(f[6])))
    return rows


def main():
    rows = dump()

    # group by flow; keep (iface -> {seq: payload})
    flows = defaultdict(lambda: defaultdict(dict))
    for iface, src, sp, dst, dp, seq, payload in rows:
        flows[(src, sp, dst, dp)][iface][seq] = payload

    # identify the modified flow: some seg with differing payload across taps
    changed = None
    for flow, sides in flows.items():
        if 0 in sides and 1 in sides:
            for seq in set(sides[0]) & set(sides[1]):
                if sides[0][seq] != sides[1][seq]:
                    changed = flow
    assert changed, "no modified flow found"
    print("modified flow:", changed)

    sides = flows[changed]
    seqs = sorted(set(sides[0]) & set(sides[1]))
    ing = b"".join(sides[0][s] for s in seqs)
    eg = b"".join(sides[1][s] for s in seqs)
    blob = bytes(a ^ b for a, b in zip(ing, eg))

    z = zipfile.ZipFile(io.BytesIO(blob))
    for name in z.namelist():
        print("== %s ==" % name)
        print(z.read(name).decode(errors="replace"))

    flag = next(z.read(n).decode() for n in z.namelist()
                if "0xV01D{" in z.read(n).decode())
    print("FLAG:", flag.strip().split("Flag: ")[1])


if __name__ == "__main__":
    sys.exit(main())
