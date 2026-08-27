#!/usr/bin/env python3
"""Between The Lines — trailing whitespace per line: tab=1, space=0, MSB-first, 8 bits/byte."""
import re

bits = []
for line in open("poem.txt", encoding="utf-8"):
    m = re.search(r"[ \t]+$", line)
    if not m:
        continue
    for ch in m.group(0):
        bits.append("1" if ch == "\t" else "0")
data = bytes(int("".join(bits[i:i + 8]), 2) for i in range(0, len(bits) - 7, 8))
print(data.decode().rstrip("\x00"))
