# Echoes in the WAL — SOLVED

**Status:** solved

**Flag:** `0xV01D{the_wal_keeps_old_promises}`

**Verification:** solver.py replays the WAL to tx47, decrypts with AES-256-GCM and prints handoff.txt

## Method
- Evidence: `nightjar.db` (SQLite, WAL mode) + `nightjar.db-wal`, `app_config.json`, `device.xml`, `notification_history.log`.
- Parsed the WAL frame-by-frame (24 frames @4096 B pages), overlaid frames over the base DB, and dumped `attachments` at each commit boundary.
- Snapshot at tx=47 commit (matching notification "attachment ready [thread=17 revision=4 tx=47]") contains the valid row: rev 4, state `ready`, nonce + 9548 B payload.
- Key = SHA-256(`android_id:thread_id:revision:committed_ms`) = SHA-256(`a91f32d06c74be18:17:4:1784062991842`); AAD = `thread=17;revision=4`; AES-256-GCM decrypt → ZIP with `handoff.txt` containing the flag.

**Technique tags:** forensics, sqlite, WAL, AES-GCM, key derivation
**Signals:** WAL-mode DB with purge after "ready"; config describing key material; timestamps in log map to txlog commits.
**Reusable takeaway:** Replay WAL frames commit-by-commit to recover rows deleted/overwritten later; derive encryption keys from documented key-material format + row fields.
