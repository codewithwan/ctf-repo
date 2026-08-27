# Safety Bitfield — SOLVED

**Status:** solved

**Flag:** `0xVoid{bits}`

**Verification:** solver.py groups allowed flags 8/byte in file order and prints the flag

## Method
- `safety_bits.txt` is a list of `{token_id, allowed}` in file order.
- "not in token-id order" → use file order; `allowed` is the bit, MSB-first,
  8 entries per byte → flag.

**Technique tags:** AI, stego, bitfield
**Signals:** "records one-bit safety decisions, but not in token-id order".
**Reusable takeaway:** One-bit decisions listed in non-id order are a bit stream in file order.
