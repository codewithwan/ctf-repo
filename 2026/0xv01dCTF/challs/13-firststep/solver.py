#!/usr/bin/env python3
"""FirstStep — single-byte XOR; key 0x42 recovers the flag."""
import sys

ct = bytes.fromhex(open("cipher.txt").read().strip())
for key in range(256):
    pt = bytes(b ^ key for b in ct)
    if pt.startswith(b"0xV0") or pt.startswith(b"0xV01D"):
        print("key =", hex(key), pt.decode())
