#!/usr/bin/env python3
"""BabyRSA — e=3 and c << n: plaintext is the exact integer cube root of c."""
import glob, os, re, subprocess, tempfile

rar = glob.glob(os.path.join(os.path.dirname(__file__), "*.rar"))[0]
with tempfile.TemporaryDirectory() as tmp:
    subprocess.run(["unar", "-o", tmp, rar], check=True, capture_output=True)
    txt = ""
    for root, _, files in os.walk(tmp):
        for fn in files:
            if fn == "challenge.txt":
                txt = open(os.path.join(root, fn)).read()
    n = int(re.search(r"n\s*=\s*(\d+)", txt).group(1))
    e = int(re.search(r"e\s*=\s*(\d+)", txt).group(1))
    c = int(re.search(r"c\s*=\s*(\d+)", txt).group(1))

lo, hi = 0, 1 << ((c.bit_length() + e - 1) // e)
while lo < hi:
    mid = (lo + hi + 1) // 2
    if mid ** e <= c:
        lo = mid
    else:
        hi = mid - 1
assert lo ** e == c, "not an exact power -- different attack needed"
print(lo.to_bytes((lo.bit_length() + 7) // 8, "big").decode())
