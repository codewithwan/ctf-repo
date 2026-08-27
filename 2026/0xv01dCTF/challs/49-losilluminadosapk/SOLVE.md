# LosIlluminados.apk — solve

**Flag:** `0xV0ID{l0s_1llum1n4d0s_h4v3_sp0tt3d_y0u}`
**Verified:** deterministic decrypt of `assets/illuminados_signal.bin` yields a
clean JSON bundle containing the flag; matches stated format `0xV0ID{...}`.
Not submitted.

## Technique tags
mobile · broadcast receiver · HMAC-SHA256 key derivation · XOR + pair-swap transform

## Signals
- Exported `los.illuminados.IlluminadosReceiver`, action `com.los.illuminados.RECEIVE`.
- `IlluminadosDecoder.deriveKey`: HMAC-SHA256, key = action string, msg = `pkg|IlluminadosReceiver`.
- `decryptBundle`: byte-pair swap then cyclic XOR with key.
- Decoys: `monitor_key`/`debug_token` in strings.xml, `NOTICE.txt` — all fake.

## Solve
1. key = `HMAC-SHA256("com.los.illuminados.RECEIVE", "los.illuminados|IlluminadosReceiver")` (32 B).
2. `illuminados_signal.bin`: bytes 0..4 `LOSIL`, byte[5] = 1 → payload = bytes[7:].
3. Swap each adjacent byte pair, XOR cyclically with key → JSON:
   `{"channel":"los/illuminados/primary","seq":13,"flag":"0xV0ID{...}","auth":"verified"}`

## Reusable takeaway
"Encrypted bundle" APKs usually derive the key from constants visible in the
decoder class — reimplement `HMAC`/`Cipher`/transform locally instead of chasing
decoy strings.
