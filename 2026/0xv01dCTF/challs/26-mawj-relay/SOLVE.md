# Mawj Relay

**Status:** solved

**Flag:** `0xV01D{push_receiver_xor_is_not_crypto}` (recovered, unverified — not submitted)

**Technique tags:** mobile, apk, anti-AI decoys, XOR cipher, hardcoded key derivation, notification routing

**Signals:** mawj.zip -> kizcjo.apk with a plaintext AndroidManifest (receiver com.void.echo.PUSH, label EchoPush), a fake classes.dex that is ASCII text with FAKE_FLAG and instructions to ignore strings.xml, decoy flags in README_NOTE.txt/strings.xml, and assets/push_routes.bin (VPUSH1) plus strings.xml route_hint "key = sha256(action + ':' + label)".

**Failed approaches:** AES-GCM layouts, AES-ECB blocks, and keystream XOR (sha256(key||i)) all fail; decoy flags (ai_took_the_push_bait, debug_strings_are_decoys) are not the flag.

**Verification:** cyclic XOR of push_routes.bin bytes from offset 9 (after the 6-byte VPUSH1 magic + 3 header bytes) with sha256("com.void.echo.PUSH:EchoPush") yields a JSON route record containing the flag verbatim; 133/133 bytes printable.

**Reusable takeaway:** When a mobile challenge ships multiple planted "flags" plus anti-tool traps (fake dex, malformed resources), treat them as decoys until they verify; trust in-app hints (here the route_hint in strings.xml) and manifest constants over decoy strings, and check simple cyclic-XOR with a derived key before reaching for block ciphers.

## Method
- Unzip mawj.zip -> kizcjo.apk; unzip APK; read plaintext AndroidManifest.xml for action/label.
- Note strings.xml route_hint: key = sha256(action + ':' + label) -> sha256("com.void.echo.PUSH:EchoPush").
- XOR push_routes.bin from byte 9 cyclically with the 32-byte key -> JSON with flag.

## Solve
`solver.py` extracts both archives, derives the key from the manifest constants, and prints the decrypted route JSON.
