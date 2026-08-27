# Confidence Cipher — SOLVED

**Status:** solved

**Flag:** `0xVoid{sampling}`

**Verification:** solver.py XORs confidence_percent with cipher and prints the flag

## Method
- `confidence_log.csv`: per-token `confidence_percent` and `cipher` bytes.
- XOR them per row: `flag_byte = confidence_percent ^ cipher`.

**Technique tags:** AI, crypto, XOR
**Signals:** description literally says confidence scores "are the XOR key stream".
**Reusable takeaway:** Columns that look like telemetry can be the key stream; XOR the stated key column with the cipher column.
