# V01D Handout 2

**Status:** solved

**Flag:** `0xV0ID{P4r7_2_15_2_C0MPL1C473D_Y4H?}` (recovered, unverified — not submitted)

**Technique tags:** crypto, singular-curve dlog, ECDSA related-nonce, SHA-256 length extension

**Signals:** client ships full scheme; discriminant zero -> singular split node; k2 = k1 + drift(NODE_D) in client; observer tag + secret_len=33 -> length extension.

**Failed approaches:** double-padding `extra` to a block boundary during length extension; hand-rolled SHA-256 compress used `_rol` amounts (ROTR26/19/10-style) instead of ROTR 6/11/25 and 2/13/22.

**Verification:** movement I map checked against client add/mul for 20 scalars and mul(NODE_D, G) == node; movement II recovers log auth_x exactly; length-extension harness equals hashlib on synthetic 33-byte secret; decrypted body starts with BROADCAST prefix and ends with TAIL.

**Reusable takeaway:** When the client ships the full scheme, treat its constants (nonce drift, mdpad construction, hex formatting) as ground truth. SHA-256 length extension needs only the known tag state, the extra bytes, and the true total length — never re-pad `extra` separately, and use real ROTR amounts or you silently get garbage.

## Method
- I: singular curve `y^2 = x^3 + Ax + B` over P with `4A^3+27B^2 ≡ 0`; double root `alpha`; map node group to F_p* via `phi(x,y) = (Y - sX)(Y + sX)^-1`, `s = sqrt(3*alpha)`; `P-1` is smooth -> sympy `discrete_log` -> `NODE_D`.
- II: `k2 = k1 + drift(NODE_D)`, drift = SHA256("DEADHAND/DRIFT/" + str(NODE_D)) % SN; recover `AUTH_X` from the two ECDSA equations.
- III: `observer = SHA256(secret || WARRANT)`; architect = length-extension of observer state with `UPGRADE || hex(AUTH_X)`, total length `33 + 22 + 9 + 21 + 64 = 149`; XOR keystream to decrypt broadcast.

## Solve
`solver.py` chains all three movements and prints the flag.
