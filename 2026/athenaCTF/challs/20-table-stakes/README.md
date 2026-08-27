# Table Stakes

- **Category:** REV
- **Points:** 175
- **Solves:** 11
- **URL:** https://ctf-2026.ctf-platform.xyz/challenges/yxch20mt8cv97ap3u2tu4tud

## Description
A small binary was recovered from a compromised endpoint. It checks a candidate flag and reports whether it is correct:
```
./challenge.bin 'athena{...}'
```
It will not reveal the flag on its own — the answer is only ever verified, never printed. Reverse engineer to recover the embedded payload.

## Files (download manual)
- `challenge.bin` — 14.6 KB (ELF) → taruh di folder ini

## Instance
Not required

## Hints
- Hint 1: −50 · Hint 2: −50 · Hint 3: −50

## Dugaan
Flag-checker: verifikasi input lawan tabel/transform (nama "Table Stakes" → lookup table). Reverse konstanta/tabel → balik transform → recover flag. Gw bisa reverse statis (objdump) kayak Logic Puzzle. Kirim `challenge.bin`.
