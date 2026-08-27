# System Prompt Chunks — SOLVED

**Status:** solved

**Flag:** `0xVoid{sorted_by_context}`

**Verification:** solver.py sorts chunks by segment_index, base64-decodes and prints the flag

## Method
- `context_chunks.json`: chunks carry `segment_index` (the original context
  slot) and base64 payloads.
- Sort by `segment_index`, base64-decode, concatenate.

**Technique tags:** AI, stego, base64, ordering
**Signals:** "shuffled segment indexes by accident"; `chunk_index is the original context slot`.
**Reusable takeaway:** Fragments with explicit indices → sort then decode.
