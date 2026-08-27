#!/usr/bin/env python3

with open("extracted/flag.enc", "rb") as f:
    enc = f.read()

# Known plaintext prefix
prefix = b"bushbash{"

# Derive the key by XORing ciphertext with known prefix (key length is 8)
key = bytes([a ^ b for a, b in zip(enc[:8], prefix[:8])])

# Decrypt the entire message
flag = bytes([b ^ key[i % len(key)] for i, b in enumerate(enc)])

print(f"Key (hex): {key.hex()}")
print(f"Flag: {flag.decode()}")
