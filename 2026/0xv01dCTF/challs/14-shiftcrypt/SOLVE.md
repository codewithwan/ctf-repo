# ShiftCrypt — SOLVED

**Status:** solved

**Flag:** `0xV0ID{v1g3n3r3_byt3_sh1ft}` (recovered by decrypt; unverified submit)

**Verification:** solver.py decrypts with key VOID and prints the flag

## Method
- 4-byte repeating key byte-shift: `ct[i] = (pt[i] + key[i%4]) % 256`.
- `cipher.txt` gave hex `86c79f749f93c4ba87b67cb289c17ca3b8c8bd77b5c2b175bcc3c6`.
- Key is a common 4-letter word. Guessing plaintext prefix `0xV0ID{` derives
  `key = (ct[i]-pt[i]) % 256` = `VOID`.
- Decrypting with `VOID` yields the flag cleanly.

**Technique tags:** crypto, vigenere, byte-shift, known-plaintext prefix
**Signals:** hex ciphertext + "4-byte keyword cipher" + "common 4-letter word"; theme word `VOID` as key.
**Reusable takeaway:** For repeating-key shift ciphers, derive the key from a
known plaintext prefix (`0xV0ID{` / `0xV01D{`), then decrypt fully.
