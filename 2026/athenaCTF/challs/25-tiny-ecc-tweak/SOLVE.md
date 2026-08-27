# Tiny ECC Tweak — SOLVED

**Flag:** `athena{n0nc3_r3us3_3cc}`

- **Category:** CRYPTO
- **Vuln:** ECDSA **nonce reuse** (broken RNG) → recover private key → derive AES key → decrypt.

## Anomali
Di `pub.txt`, `sig1_r == sig2_r`. Karena `r = (k·G).x`, r yang sama = **nonce `k` yang sama**
dipakai buat sign dua pesan beda. Itu fatal buat ECDSA.

## Recover key
Curve = secp256k1, hash = SHA-256, `z = SHA256(msg)`.
```
s1 = k⁻¹(z1 + r·d) mod n
s2 = k⁻¹(z2 + r·d) mod n
=> k = (z1 - z2) / (s1 - s2) mod n
=> d = (s1·k - z1) / r mod n
```
Verifikasi `d·G == pubkey` (cocok).
- `d = 0x3caf67a22ee440123acb9e50d3c7bb63ba21afeef0eb3ba0ed81796878f2e5d1`

## Decrypt payload
AES-GCM, nonce & ciphertext(+tag 16B) dari file. Key = **SHA256(d sebagai 32 byte big-endian)**.
Tag ter-verify → plaintext = `athena{n0nc3_r3us3_3cc}`.

Full script: [solve.py](solve.py)
