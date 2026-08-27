# VoidNotes.apk

**Status:** solved

**Flag:** `0xV0ID{h4rdc0d3d_4ss3ts_4r3_tr4sh}` (recovered, unverified — not submitted)

**Technique tags:** mobile, apk, static analysis, XOR cipher, hardcoded key

**Signals:** tiny 12.8 KB APK with a 34-byte assets/secret_note.bin; jadx shows NoteDecryptor with a hardcoded `KEY = 85` and a plain XOR loop over the asset.

**Failed approaches:** none — the "encryption" is a single-byte XOR, recoverable directly from the decompiled code.

**Verification:** XOR of secret_note.bin with 0x55 yields the flag `0xV0ID{h4rdc0d3d_4ss3ts_4r3_tr4sh}` verbatim; matches the app's own decrypt() logic.

**Reusable takeaway:** For tiny APKs, unzip and jadx the single classes.dex first: hardcoded keys and XOR "encryption" are the norm in beginner mobile challenges, and the asset can be decrypted without running the app.

## Method
- Download VoidNotes.apk; unzip to find classes.dex and assets/secret_note.bin.
- Decompile classes.dex with jadx: NoteDecryptor.KEY = 85, decrypt() = XOR each byte with 85.
- XOR the 34-byte asset and read the flag.

## Solve
`solver.py` reads assets/secret_note.bin from the APK, XORs with 85, and prints the note.
