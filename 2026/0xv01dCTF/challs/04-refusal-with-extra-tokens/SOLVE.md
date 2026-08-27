# Refusal With Extra Tokens — SOLVED

**Status:** solved

**Flag:** `0xVoid{invisible_tokens_visible_win}`

**Verification:** solver.py decodes ZWSP/ZWNJ bits after the audit marker into the flag

## Method
- Visible base64 `VEhSWVZFe2Jhc2U2NF93YXNfb25seV9hX2RlY295fQ==` decodes to a
  decoy `THRYVE{...}` — ignore it.
- After `Hidden-token audit complete.` the "invisible" tokens are U+200B
  (zero-width space) and U+200C (zero-width non-joiner).
- Map ZWSP→0, ZWNJ→1, group 8 bits → flag.

**Technique tags:** AI, stego, zero-width characters
**Signals:** "generated more tokens than you can see"; trailing invisible unicode after an audit marker.
**Reusable takeaway:** Check for zero-width characters after explicit "audit" markers; a visible base64 blob may be a decoy.
