# Temperature Seven — SOLVED

**Status:** solved

**Flag:** `0xVoid{temperature_is_not_a_secret}`

**Verification:** solver.py XORs cipher bytes with 7 and prints the flag

## Method
- `output.txt` gives a decimal cipher array and claims XOR with temperature 0.7.
- The effective key is `int(0.7 * 10) = 7`: `pt = cipher_byte ^ 7`.

**Technique tags:** AI, crypto, XOR
**Signals:** "I simply believed 0.7 looked like a key" — the float's only usable byte is 7.
**Reusable takeaway:** A "temperature" key hint maps to an integer key; try `int(t*10)`.
