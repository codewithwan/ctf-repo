# Simple Calculator

- **Category:** REV
- **Points:** 375
- **Solves:** 6
- **URL:** https://ctf-2026.ctf-platform.xyz/challenges/mrsi8e70oonxdtf5yb5pm5dg

## Description
Recovered from a compromised handset: a plain-looking "Simple Calculator" that field intelligence links to a rogue cell of CIA hackers. Word is it doubles as a spy's burner tool -- a piece of quiet James Bond tradecraft hiding in plain sight on the home screen. To anyone watching, it just adds numbers. To the operator who knows the right moves, it gives up a secret. You've been handed the release APK. Decompile it, work out what it's really doing behind the arithmetic, and coax it into revealing what it was built to protect. Not everything inside is what it looks like. Submit the flag in the form `athena{...}`.

## Files (download manual)
- `illogical.apk` — 938 KB (Android APK) → taruh di folder ini

## Instance
Not required

## Hints
- Hint 1: −75 · Hint 2: −100 · Hint 3: −150

## Dugaan
Android RE: decompile APK (jadx/apktool). Ada "secret sequence" input di kalkulator (kombinasi tombol tertentu) yang trigger reveal flag. Cari di smali/java: string check, hidden activity, atau flag ter-encode (base64/XOR). Kirim `illogical.apk`, gw decompile.
