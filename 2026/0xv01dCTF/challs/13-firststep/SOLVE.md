# FirstStep — SOLVED

**Status:** solved

**Flag:** `0xV01D{W3LC0M3_T0_CTF}` (recovered by decrypt; unverified submit)

**Verification:** solver.py finds key 0x42 whose decryption matches the flag prefix

## Method
- `cipher.txt` hex `723a147273063915710e01720f711d16721d0116043f` (27 bytes).
- Brute-forced single-byte XOR (0..255); key `0x42` (`B`) yields the flag.

**Technique tags:** crypto, xor, single-byte key
**Signals:** short hex blob, "everyone walks through the same door" → one key.
**Reusable takeaway:** Try single-byte XOR over the key space and look for the
flag prefix in the output.
