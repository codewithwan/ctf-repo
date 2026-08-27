# Simple Calculator — Athena CTF 2026 (REV, 375)

**Flag:** `athena{2850289b2ace6865dc26fccf571b1f2a}`

---

## Summary

`illogical(1).apk` is a working Android calculator (`me.mahakagg.calculator.MainActivity`).
Behind the arithmetic it watches for a **16-digit secret keypad sequence**. When entered
correctly it uses reflection to call a hidden `private void revealFlag()`, which
**AES-CBC-decrypts** an embedded ciphertext and pops the flag in a dialog.

Single `classes.dex`, no assets/lib. Decompiled with **androguard 4.1.4** (jadx/apktool absent).

## The hidden trigger (secret button sequence)

`onNumClick` routes digit presses (except the `4` button, see below) into `w(String)`.
`w()` walks a per-press index `this.b` and compares each digit against a decoded table:

```
expected_digit[i] = MainActivity.a[i] ^ ((((i*11) ^ 55) + 100) & 255)
MainActivity.a = {152,167,133,127,125,108,216,216,218,187,184,176,31,28,23,247}
```

This yields the **16-key code to type on the keypad:**

```
3 7 0 5 2 8 1 6 9 3 5 2 8 0 6 1   ->  "3705281693528061"
```

Checkpoints `MainActivity.b = {5, 11, 16}` fire toasts "Stage 1 complete!" (after `37052`)
and "Stage 2 complete!" (after `...6935`). Reaching index 16 builds the string
`"revealFlag"` from `MainActivity.g` and invokes it via
`getDeclaredMethod("revealFlag").invoke(this)`. Any wrong digit resets progress.

(The sequence deliberately contains no `4` — the `4` button is a separate red-herring
"spy" feature that starts an audio recorder after 9 presses via `RECORD_AUDIO`.)

## Where the encoded flag lives / the decode

`revealFlag()` does AES/CBC/PKCS5Padding:

- **Key material (8 bytes):** `MainActivity.c[i] ^ g9.a[i]`
  - `MainActivity.c = {63,161,200,125,18,158,68,182}`
  - `g9.a = {92,13,154,46,241,99,170,23}`  ← the `int[8] a` field, first assignment in
    the huge obfuscated `g9` static initializer (many collision fields named `a`; the
    `[I` one is the key)
  - -> `63ac5253e3fdeea1`
- **AES key:** `SHA-256(keyMaterial)[:16]` = `6fc3b8c31ca7aa49ee0ef7bd734b1bf5`
- **IV (16):** `MainActivity.d = {17,159,60,132,45,94,176,119,8,145,196,42,102,253,19,232}`
- **Ciphertext (48):** `MainActivity.e = {245,205,184,41,...,176,113}`

Decrypt -> `athena{2850289b2ace6865dc26fccf571b1f2a}` + 8×`0x08` padding (valid PKCS5).

## Decoy ("Not everything inside is what it looks like")

`MainActivity.f` (33 bytes) decodes with `f[i] ^ ((((i*5)^44)+145)&255)` to the **fake flag**
`athena{keep_digging_this_isnt_it}` (only shown if `System.currentTimeMillis() < 0`,
i.e. never). Do not submit this one.

## Verification

- Real flag decrypts with correct PKCS5 padding and clean UTF-8.
- Format matches `athena{...}` with 32 lowercase hex chars.
- **Confidence: high.**

## Solver

Run `python3 solve.py` (needs `pycryptodome`).
