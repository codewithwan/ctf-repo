# Checkpoint Seed — SOLVED

**Status:** solved

**Flag:** `0xVoid{seeded_models_dream_the_same_dream}`

**Verification:** solver.py XORs the published RNG stream and prints the flag verbatim from checkpoint.json

## Method
- `checkpoint.json` exposes `seed=8675309` and the masking algorithm verbatim:
  `random.Random(seed).randrange(256)` per byte.
- XOR `cipher_hex` with that stream → flag.

**Technique tags:** AI, crypto, XOR, PRNG seed
**Signals:** "reproducibility: exact" + published seed + algorithm string in the JSON.
**Reusable takeaway:** When a challenge publishes the PRNG seed and algorithm, just
reproduce the stream — "random means random" only if the seed is secret.
