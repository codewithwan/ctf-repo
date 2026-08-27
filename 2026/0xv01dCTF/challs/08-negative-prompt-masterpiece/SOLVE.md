# Negative Prompt Masterpiece — SOLVED

**Status:** solved

**Flag:** `0xVoid{negative_prompt_positive_flag}`

**Verification:** solver.py dumps the PNG tEXt NegativePrompt chunk containing the flag

## Method
- Parse PNG chunks; the `tEXt` chunk `NegativePrompt` contains the flag as
  plaintext ("no plaintext, no spoilers, definitely no 0xVoid{...}").
- (LSB-plane analysis of the image pixels was a fake-out.)

**Technique tags:** AI, stego, PNG metadata
**Signals:** "insisted the secret was removed from the prompt" → read the prompt metadata.
**Reusable takeaway:** Check PNG `tEXt`/`iTXt`/`zTXt` chunks before pixel stego.
