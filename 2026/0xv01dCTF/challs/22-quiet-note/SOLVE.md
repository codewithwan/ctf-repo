# Quiet Note — SOLVED

**Status:** solved

**Flag:** `0xV01D{FIRST_LETTERS_NEVER_LIE}`

**Verification:** solver.py joins first characters of every line and prints the flag

## Method
- `letter.txt`: every line repeats the same sentence but starts with a distinct
  character; the first character of each line spells the flag.

**Technique tags:** misc, acrostic
**Signals:** repetitive lines with varying leading characters.
**Reusable takeaway:** First-letter acrostic; flag may also be hidden in first word/letters.
