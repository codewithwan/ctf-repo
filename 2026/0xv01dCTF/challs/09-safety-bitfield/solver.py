#!/usr/bin/env python3
"""Safety Bitfield — allowed bits in file order, MSB-first, 8 per byte."""
import json

rows = json.load(open("safety_bits.txt"))
bits = ["1" if r["allowed"] else "0" for r in rows]
data = bytes(int("".join(bits[i:i + 8]), 2) for i in range(0, len(bits) - 7, 8))
print(data.decode())
