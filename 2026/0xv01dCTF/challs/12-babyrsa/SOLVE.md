# BabyRSA — SOLVED

**Status:** solved

**Flag:** `0xV0ID{cub3_r00t_4tt4ck}` (recovered by decrypt; unverified submit)

**Verification:** solver.py confirms m**3 == c and the bytes decode to the flag

## Method
- RSA with `e=3` and ciphertext far smaller than `n` → `m = c^(1/3)` exactly.
- Integer cube root by binary search; `m**3 == c` confirms.
- Bytes of `m` are the flag.

**Technique tags:** crypto, RSA, small-e, cube-root attack
**Signals:** tiny exponent e=3, ciphertext far smaller than modulus, no padding.
**Reusable takeaway:** With a tiny exponent and ciphertext far below the modulus, take the exact integer root of the ciphertext instead of factoring.