# PingBack.apk — solve

**Flag:** `0xV0ID{p1ng_b4ck_r3c31v3r_unl0ck3d_v14_1nt3nt}`
**Verified:** AES-CBC decrypt of `assets/signal.enc` reproduces the plaintext
exactly (valid PKCS#5 padding). Not submitted.

## Technique tags
mobile · broadcast receiver · AES-CBC · SHA-1 key derivation

## Signals
- Manifest: exported `com.pingback.app.UnlockReceiver` with action `com.pingback.ACTION_UNLOCK`.
- Receiver validates extras `auth` and `seq` before decrypting `assets/signal.enc`.

## Solve
1. `auth = "SYNC-2026-PING"`, `seq = 12 - 1 = 11` (from `UnlockReceiver`).
2. AES key = first 16 bytes of `SHA-1(auth + "11")`.
3. IV = `0f1e2d3c4b5a69788796a5b4c3d2e1f0`.
4. `AES/CBC/PKCS5Padding` decrypt of `signal.enc` → plaintext flag.

## Reusable takeaway
Exported receivers with hardcoded tokens are pure static-analysis solves:
reimplement the validation constants and cipher parameters locally; no device needed.
