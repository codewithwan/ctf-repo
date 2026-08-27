# Transmission — SOLVED

**Status:** solved

**Flag:** `0xV01D{h1dd3n_1n_th3_sp3ctr0}` (confirmed on platform by user)

**Technique tags:** steganography, audio, spectrogram, zip-crypto, password cracking

**Signals:** challenge says "strange transmission … what's really in that signal" →
audio → spectrogram. Attachment is a password-protected zip containing `unknown.unknown`.

## Method
1. ZipCrypto (deflate) zip, no hint in metadata. Crack password with john + rockyou
   (`--format=pkzip`): **`whatever1`**.
2. Extract `unknown.unknown` → `file`: RIFF/WAVE, PCM 16-bit mono 44100 Hz, exactly 6 s.
3. `scipy.signal.spectrogram`, band 5.8–11 kHz, message occupies t≈1.1–4.9 s:
   the audio is an image→audio render where text pixels became chords of tones.
4. The drawn text is horizontally mirrored — `Image.FLIP_LEFT_RIGHT` yields
   `0xV01D{h1dd3n_1n_th3_sp3ctr0}`.

**Reusable takeaway:** for audio stego, first do a spectrogram (log-ish view of the
full band); if you see clear glyphs but they read backwards, flip the time axis.

## Solve
`solver.py` unlocks the zip, renders `spectrogram_mirrored.png`, prints the flag.
