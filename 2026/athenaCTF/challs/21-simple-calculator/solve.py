#!/usr/bin/env python3
"""Simple Calculator (Athena CTF 2026) solver.
Recovers the 16-digit keypad trigger and AES-decrypts the flag from MainActivity.
"""
import hashlib
from Crypto.Cipher import AES

# --- static arrays pulled from me.mahakagg.calculator.MainActivity ---
A  = [152,167,133,127,125,108,216,216,218,187,184,176,31,28,23,247]  # secret-seq codes
B  = [5,11,16]                                                        # stage checkpoints
C  = [63,161,200,125,18,158,68,182]                                  # key material part 1
D  = [17,159,60,132,45,94,176,119,8,145,196,42,102,253,19,232]       # AES IV (16)
E  = [245,205,184,41,254,221,13,34,83,237,14,31,159,52,213,126,143,87,227,102,236,
      50,128,221,68,74,109,102,5,238,93,240,171,127,168,127,100,135,81,245,127,194,
      207,85,158,5,176,113]                                          # ciphertext (48)
F  = [220,206,223,209,167,167,184,203,240,247,223,243,197,151,156,159,100,100,96,91,
      173,190,186,131,186,139,76,82,69,17,34,60,96]                  # hidden toast (33)
g9a = [92,13,154,46,241,99,170,23]                                   # g9.a  int[8]

# 1) secret keypad sequence
seq = [A[i] ^ ((((i*11) ^ 55) + 100) & 255) for i in range(16)]
print("Secret keypad sequence :", "".join(map(str, seq)))
print("Stage checkpoints      :", B, "(toasts fire at press #)")

# 2) decoy string
decoy = "".join(chr(F[i] ^ ((((i*5) ^ 44) + 145) & 255)) for i in range(33))
print("Decoy string           :", decoy)

# 3) real flag
km  = bytes((C[i] ^ g9a[i]) & 0xFF for i in range(8))
key = hashlib.sha256(km).digest()[:16]
pt  = AES.new(key, AES.MODE_CBC, bytes(D)).decrypt(bytes(E))
flag = pt[:-pt[-1]].decode()   # strip PKCS5
print("AES key material       :", km.hex())
print("AES key (sha256[:16])  :", key.hex())
print("FLAG                   :", flag)
