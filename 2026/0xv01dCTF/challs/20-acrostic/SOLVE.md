# Acrostic

**Status:** solved

**Flag:** `0xV0ID{FIRSTSTEP}` (recovered from message.txt acrostic, verified against description format — not submitted, 1-attempt limit)

**Technique tags:** misc, acrostic, plain-sight

**Signals:** "Read carefully — the first letter of each line reveals the secret." The fetched `message.txt` is the intercepted network message; flag format explicitly stated as `0xV0ID{......}`.

**Verification:** byte-level check of message.txt: 9 lines, pure ASCII, no hidden/zero-width chars, no trailing whitespace. First char of each line: F, I, R, S, T, S, T, E, P -> FIRSTSTEP.

**Prefix check:** challenge description states `0xV0ID{......}` explicitly (V-zero), so the flag is `0xV0ID{FIRSTSTEP}` — not `0xV01D`. Sibling challenges that state `0xV01D{...}` (e.g. FirstStep) use the V-one prefix, so each challenge's stated format is authoritative.

**Reusable takeaway:** For acrostics, hexdump the file first (rules out zero-width/unicode tricks), then take the first byte of each line; trust the description's stated flag format over cross-challenge consistency.

## Solve
`solver.py` prints the acrostic and the final flag.
