#!/usr/bin/env python3
"""
Cache Footprint - Athena CTF 2026 (Forensics, 200)

The download row id=6 was DELETED from the `downloads` table, but delete != erase:
its bytes still live in unallocated / freeblock space of the SQLite file.

Carve the deleted record from raw bytes, then apply the export mechanism recorded
in session_storage:  export_format=base64, export_cipher=xor(device_id),
device_id cookie = kiosk-0419.
"""
import re
import base64
import sqlite3

DB = "browser_history.sqlite"

# 1) Confirm id=6 is missing from the LIVE downloads table.
con = sqlite3.connect(DB)
live_ids = [r[0] for r in con.execute("SELECT id FROM downloads ORDER BY id")]
print("Live download ids:", live_ids, "-> missing:", sorted(set(range(1, max(live_ids)+1)) - set(live_ids)))

# 2) Carve the deleted record from RAW file bytes (freeblock / unallocated).
raw = open(DB, "rb").read()
# The deleted row's data: URI survives in unallocated space.
m = re.search(rb"data:application/octet-stream;base64,([A-Za-z0-9+/=]+)/tmp/notes\.txt", raw)
payload_b64 = m.group(1).decode()
print("Carved deleted row payload (base64):", payload_b64)

# 3) Decode: base64 -> XOR with device_id key.
device_id = con.execute(
    "SELECT value FROM cookies WHERE name='device_id'").fetchone()[0].encode()
blob = base64.b64decode(payload_b64)
flag = bytes(b ^ device_id[i % len(device_id)] for i, b in enumerate(blob))
print("device_id key:", device_id.decode())
print("FLAG:", flag.decode())
