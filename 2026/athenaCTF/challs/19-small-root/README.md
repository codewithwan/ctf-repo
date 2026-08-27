# Small Root

- **Category:** CRYPTO
- **Points:** 100
- **Solves:** 17
- **URL:** https://ctf-2026.ctf-platform.xyz/challenges/g4kq0ffr2pmvegx3deoz8zp4

## Description
Deep in the Sahar's jungle, a jungle so dense that satellites lose signal between the canopies. A lone owl carries a secret dispatch between two resistance cells. Intercepted mid-flight, the message and the parameters used to seal it are now in your hands. The sender was careless. They chose a method so weak that the night air itself could unravel it. Everything you need is in `pub.txt`. Recover what the owl was carrying. The jungle does not wait.

## Files (download manual)
- `pub.txt` — 5.3 KB → taruh di folder ini

## Instance
Not required

## Hints
- Hint 1: −35 · Hint 2: −35

## Dugaan
RSA dengan **small exponent / small root** (Coppersmith / low-e, atau e=3 root cube). "method so weak" → kemungkinan e kecil + m^e < n, atau pesan pendek → tinggal akar. Kirim `pub.txt` ke gw, tinggal gw solve.
