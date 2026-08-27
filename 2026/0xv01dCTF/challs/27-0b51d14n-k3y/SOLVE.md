# 0b51d14n_k3y

**Status:** solved

**Flag:** `0xV01D{obsidian_cold_blade_forged_from_native_shards}` (recovered, unverified — not submitted)

**Technique tags:** mobile, apk, native library, leftover source, key fragments, AES-GCM, sqlite

**Signals:** obsidian_key.zip wraps a tiny APK carrying libshard.c (leftover dev artifact) with SKFRAG0..3 key fragments + "seq=2,0,3,1" order; assets/shard.db holds a master_shard row with iv/tag/ciphertext/context. NOTICE.txt and meta.ai_bait are planted decoys ("prompt injection stays outside the vault").

**Failed approaches:** decoy flags in assets/NOTICE.txt and sqlite meta (0xV01D{...}) do not pass AES-GCM; raw concatenated fragments are not a valid AES key size.

**Verification:** AES-GCM decrypt of master_shard succeeds with key = SHA-256("obsidian-cold-blade-forge") (fragments stripped of SKFRAGn: prefixes, joined in order 2,0,3,1), nonce from iv, AAD = context "shard-vault-v1", tag verified — plaintext is the flag.

**Reusable takeaway:** When a mobile APK leaks native source alongside the compiled .so, the source is ground truth for key material; look for ordered fragments + a hash-to-keysize step, and treat planted "flags" in assets/sqlite as decoys until they verify cryptographically.

## Method
- Unzip obsidian_key.zip -> ob9k3x.apk; unzip APK: libshard.c, libshard.so, assets/shard.db.
- Parse key fragments and order from libshard.c; strip "SKFRAGn:" prefixes; join as 2,0,3,1 -> "obsidian-cold-blade-forge"; SHA-256 it to a 32-byte key.
- Read master_shard (iv, tag, ciphertext, context) from shard.db; AES-GCM decrypt with AAD=context.

## Solve
`solver.py` extracts both archives, parses the fragments/order, derives the key, and prints the decrypted note.
