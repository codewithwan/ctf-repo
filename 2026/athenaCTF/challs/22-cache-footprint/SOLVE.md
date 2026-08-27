**Flag:** `athena{sqlite_kept_the_clue}`

# Cache Footprint — Athena CTF 2026 (Forensics, 200)

## TL;DR
The `downloads` table had a row **DELETED** (id=6). SQLite delete ≠ erase, so the
record's bytes survived in unallocated/freeblock space. Carve the deleted row from
the raw file, then apply the export mechanism recorded in `session_storage`:
`base64` → `xor(device_id)` with `device_id = kiosk-0419`.

## Recon
Tables: `history`, `cookies`, `form_data`, `session_storage`, `downloads`.

Live `downloads` rows have ids `1,2,3,4,5,7,8` — **id 6 is missing** (the operator's
cleanup DELETE). Timeline gap: id5 @ `08:04:01`, id7 @ `08:05:58`; history row 6
(`chrome://devtools/export?fmt=datauri` @ `08:05:12`) hints at the export.

The export recipe is literally stored in `session_storage`:
- `export_format = base64`
- `export_cipher = xor(device_id)`
- `device_id` cookie (updates.local) = `kiosk-0419`

The three `data:` URIs still visible in the DB are decoys (they base64-decode to
plain junk like "kiosk display calibration profile v3", "ERROR: access denied",
"session heartbeat ok…"). Explicitly NOT the answer.

## Carve the deleted record
No WAL/journal present; freelist header (offsets 32/36) is zero. The deleted row's
bytes remain inline in a page freeblock and are recoverable directly from the raw
file (`strings` / regex over the bytes). Recovered deleted row:

```
id=6 | 2026-05-19T08:05:26Z
source_url = data:application/octet-stream;base64,Ch0HFgVMS0dAVQIdCiwASEBAbk0DDDAQB1hVSQ==
target_path = /tmp/notes.txt
mime = application/octet-stream | status = complete
```

## Decode chain (the "how it was exported")
1. base64-decode the payload `Ch0HFgVMS0dAVQIdCiwASEBAbk0DDDAQB1hVSQ==`
2. XOR the bytes with repeating key `kiosk-0419` (the `device_id`)

```python
import base64
blob = base64.b64decode("Ch0HFgVMS0dAVQIdCiwASEBAbk0DDDAQB1hVSQ==")
key  = b"kiosk-0419"
print(bytes(b ^ key[i % len(key)] for i, b in enumerate(blob)).decode())
# -> athena{sqlite_kept_the_clue}
```

## Verification
`python3 solve.py` reproduces end-to-end: confirms id=6 missing, carves the payload
from raw bytes, pulls the `device_id` key from cookies, and prints
`athena{sqlite_kept_the_clue}`. Clean flag, matches `athena{...}` format.
