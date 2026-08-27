# V01D Handout — SOLVED

**Status:** solved

**Flag:** `0xV0ID{W0W_Y0U_4C7U4LLY_F0UND_M3!!}`

**Verification:** solver.py runs the full chain (Franklin-Reiter, LCG lattice, LFSR WHT) and prints the decrypted header + flag

## Method
Three chained seals; each unlocks the next.

- **Seal I — The Echo:** `c1 = m^5 mod n`, `c2 = (m + DELTA)^5 mod n` with
  `e=5`, small constant delta → Franklin–Reiter related-message attack
  (polynomial gcd mod n). Recovers the capsule
  `0xV0ID//SEAL-I// + 208 noise bytes + PRIME_P` → `PRIME_P`.
- **Seal II — The Drift:** 128-bit LCG mod `PRIME_P` leaking top 32 bits of 8
  consecutive states (`x >> 96`). Lattice attack (Frieze et al. / jvdsn):
  basis rows `(p, 0...)`, `(a^i, 0.., -1...)`, LLL-reduce, solve `B·x = b`
  with `b_i = round((B·y)_i / p)*p - (B·y)_i`; states are
  `y_i + x_i + delta_i`. Seed for Seal III = state `x_8`.
- **Seal III — The Static:** nonlinear combiner
  `y = (x1&x2) ^ (x2&x3) ^ x3` over three Fibonacci LFSRs (19/21/23 bits),
  taps derived via `shake_256` + primitive-polynomial check. The plaintext
  header is known → keystream bits known. `x1` and `x3` each correlate with
  `y` at 3/4 → recover via Walsh–Hadamard transform over output masks
  (`M_{t+1} = (M_t<<1) ^ (taps if top bit)`), then solve `x2` from the
  pinned equations `x2_t = y_t ^ x3_t` where `x1_t != x3_t` (GF(2) linear
  solve). XOR keystream with `ct` → flag.

## Failed / wrong turns
- z3 bit-vector model of Seal II was unsat (128-bit multiply overflow); plain
  z3 linear-integer timed out.
- Initial LLL attempt produced no candidates: wrong candidate sign convention
  and the `B·y`/rounding step was misordered; also LFSR "output masks" must use
  the adjoint transition (`T^T`), not the forward state transition.
- First WHT implementation had a stage-count bug (loop bound compared against
  the reshaped row count, dropping the final stage).
- LFSR states are **not** hidden in the 208 noise bytes (checked packed/
  chunked layouts) — they are recovered from the keystream directly.

**Technique tags:** crypto, RSA, Franklin-Reiter, LCG, truncated-state, lattice, LFSR, correlation attack, Walsh-Hadamard
**Signals:** related ciphertexts (Seal I), truncated LCG leaks (Seal II), known-plaintext header + small LFSRs (Seal III).
**Reusable takeaway:** Chain-of-seals challenges: name the primitive for each stage, then apply the classic attack (FR gcd, LLL truncated-state, WHT correlation). Verify each stage on synthetic data before trusting results.
