# Between The Lines — SOLVED

**Status:** solved

**Flag:** `0xV0ID{wh1t3sp4c3_h1d3s_4ll_truth}`

**Verification:** solver.py decodes trailing tab/space bits and prints the flag

## Method
- Each line of `poem.txt` ends with trailing spaces/tabs.
- Map tab→1, space→0, MSB-first, 8 bits per byte → flag.

**Technique tags:** misc, stego, whitespace
**Signals:** "tabs and spaces whisper"; trailing whitespace after every line.
**Reusable takeaway:** Trailing-whitespace stego: tabs vs spaces as bits, 8 per line, file order.
