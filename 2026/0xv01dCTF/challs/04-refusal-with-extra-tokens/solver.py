#!/usr/bin/env python3
"""Refusal With Extra Tokens — hidden ZWSP(0)/ZWNJ(1) bits after the audit line."""
import re

txt = open("refusal.txt", encoding="utf-8").read()
tail = txt.split("Hidden-token audit complete.", 1)[1]
bits = []
for ch in tail:
    if ch == "\u200b":
        bits.append("0")
    elif ch == "\u200c":
        bits.append("1")
data = bytes(int("".join(bits[i:i + 8]), 2) for i in range(0, len(bits) - 7, 8))
print(data.decode())
