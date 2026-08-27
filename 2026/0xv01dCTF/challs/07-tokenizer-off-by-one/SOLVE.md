# Tokenizer Off By One — SOLVED

**Status:** solved

**Flag:** `0xVoid{humans_start_at_one_models_do_not}`

**Verification:** solver.py resolves vocab[id-1] for every generated id and prints the flag

## Method
- `token_dump.json` exports a zero-indexed vocab and `generated_token_ids`.
- Warning: ids "were shifted to be friendlier for spreadsheet users" → real
  index is `id - 1`; look up `vocab[id-1]` for each id.

**Technique tags:** AI, tokenizer, off-by-one
**Signals:** "ids were shifted to be friendlier for spreadsheet users" (1-based vs 0-based).
**Reusable takeaway:** Off-by-one between 0/1 indexing is a common encoding; subtract 1 and re-index.
