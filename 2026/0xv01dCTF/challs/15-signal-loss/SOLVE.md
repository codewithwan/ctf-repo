# Signal Loss — SOLVED

**Status:** solved

**Flag:** `0xV0ID{s1gn4l_d3c0d3d_l4y3r_by_l4y3r}`

**Verification:** solver.py decodes morse → hex → ASCII and prints the flag

## Method
- `secret.wav`: 8 kHz, 8-bit mono, ~110 s. Description: encoded in multiple layers.
- Envelope analysis: bursts of a ~550 Hz tone with dot (~71 ms) and dash (~212 ms) durations → Morse code.
- Decoded Morse → hex string `307856...727D` → ASCII flag.

**Technique tags:** crypto/audio, morse, envelope decoding, hex
**Signals:** short radio transmission, beep durations ratio 1:3.
**Reusable takeaway:** For beep audio, threshold the envelope (median-filtered abs) into on/off runs, classify dot/dash by unit length, then map Morse; re-decode the resulting text/hex layer.
