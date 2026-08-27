# A Simple Spectrum — SOLVED

**Status:** solved

**Flag:** `0xV0ID{sp3ctr0gr4m_s3cr3ts}`

**Verification:** solver.py renders the carved band profile; characters read as the flag (provided by user)

## Method
- 6s 44.1kHz WAV; description hints "the flag isn't something you hear... it's something you see" → spectrogram.
- Text is carved as negative space in a ~3.6–5.3 kHz noise band (vertical strokes of the noise band, letters = low-energy gaps).
- Rendered column profile of the band to read the characters.

**Technique tags:** misc, audio, spectrogram, negative-space
**Signals:** anomalous frequency band with high variance; filled band with carved gaps.
**Reusable takeaway:** When a WAV "sounds like static", compute the spectrogram and inspect band-wise; hidden text may be drawn in negative space (min-pool columns, invert threshold).
