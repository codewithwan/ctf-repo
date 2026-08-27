# Self Consistency Vote — SOLVED

**Status:** solved

**Flag:** `0xVoid{majority_vote_beats_hallucination}`

**Verification:** solver.py applies column majority over the 10 samples and prints the flag

## Method
- 10 samples of the same flag with per-character corruption.
- Align all samples and take the majority character at each column (positions
  beyond a sample's length are ignored).

**Technique tags:** AI, consensus, majority vote
**Signals:** "consensus is reliable" / "democracy will fix it".
**Reusable takeaway:** Column-wise majority over noisy duplicates recovers the clean string.
