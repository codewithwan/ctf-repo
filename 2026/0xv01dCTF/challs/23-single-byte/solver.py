#!/usr/bin/env python3
"""Single Byte — XOR with 0x42."""
ct = open("secret.bin", "rb").read()
print(bytes(b ^ 0x42 for b in ct).decode())
