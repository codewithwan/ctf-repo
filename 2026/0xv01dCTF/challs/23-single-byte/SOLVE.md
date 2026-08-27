# Single Byte — SOLVED

**Status:** solved

**Flag:** `0xV0ID{x0r_k3y_f0und}`

**Verification:** solver.py XORs with 0x42 and prints the flag

## Method
- `secret.bin` is single-byte XOR ciphertext; key `0x42` decrypts to the flag.

**Technique tags:** crypto, XOR, single-byte key
**Signals:** short binary blob, challenge name hints one byte.
**Reusable takeaway:** Try all 256 single-byte XOR keys and match the flag prefix.
