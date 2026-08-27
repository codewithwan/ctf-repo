# Transmission

- **Category:** Steganography
- **Points:** 250
- **Solves:** 68
- **Author:** jinx69
- **URL:** https://0xv01d-ctf.xyz/challenges/64

## Description
Our team intercepted a strange transmission last night. Command wants to know
what's really in that signal.

## Files
- `Transmission.zip` (password-protected; inside: `unknown.unknown` = 6 s PCM WAV)

## Solve
`solver.py` → spectrogram, mirror horizontally, read the flag.
