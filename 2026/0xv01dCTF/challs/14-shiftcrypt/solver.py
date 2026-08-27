#!/usr/bin/env python3
"""ShiftCrypt — repeating 4-byte key (VOID) byte-shift: ct = (pt + key) % 256."""
import glob, os, re

for fn in glob.glob(os.path.join(os.path.dirname(__file__), "**", "cipher.txt"), recursive=True):
    txt = open(fn).read()
    ct = bytes.fromhex(re.search(r"Ciphertext \(hex\):\s*\n([0-9a-fA-F]+)", txt).group(1))
    break
key = b"VOID"
print(bytes((c - key[i % 4]) % 256 for i, c in enumerate(ct)).decode())
