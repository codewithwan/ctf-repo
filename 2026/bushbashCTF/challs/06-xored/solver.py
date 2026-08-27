#!/usr/bin/env python3

from pathlib import Path

ct = Path("extracted/flag.enc").read_bytes()
key = bytes.fromhex("3a3bebb319914818")
print(bytes(c ^ key[i % len(key)] for i, c in enumerate(ct)).decode())
