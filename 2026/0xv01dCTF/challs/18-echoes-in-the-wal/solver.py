#!/usr/bin/env python3
"""Echoes in the WAL — replay the SQLite WAL frame-by-frame to recover a purged
attachment row, then AES-256-GCM decrypt it with the app's key-derivation."""
import hashlib
import json
import os
import re
import sqlite3
import struct
import subprocess
import tempfile
import zipfile

BASE = os.path.join(os.path.dirname(__file__), "export")

db = open(os.path.join(BASE, "nightjar.db"), "rb").read()
wal = open(os.path.join(BASE, "nightjar.db-wal"), "rb").read()
pgsz = struct.unpack(">I", wal[8:12])[0]
nframe = (len(wal) - 32) // (24 + pgsz)

# decode WAL frames (header: magic8, pgsz4, ckpt4, salt1/2 4+4, csum 4+4)
def decode_wal(wal, pgsz):
    frames = []
    for i in range(nframe):
        off = 32 + i * (24 + pgsz)
        pgno, commit = struct.unpack(">II", wal[off:off + 8])
        frames.append((pgno, commit, wal[off + 24:off + 24 + pgsz]))
    return frames

frames = decode_wal(wal, pgsz)

def snapshot_upto(idx):
    pages = {1: db[0:pgsz]}
    for i in range(1, len(db) // pgsz + 1):
        pages[i] = db[(i - 1) * pgsz:(i) * pgsz]
    for pgno, _, data in frames[:idx + 1]:
        pages[pgno] = data
    return pages

android_id = re.search(r'name="android_id" value="([0-9a-f]+)"',
                       open(os.path.join(BASE, "device.xml")).read()).group(1)

best = None
with tempfile.TemporaryDirectory() as tmp:
    for idx, (_, commit, _) in enumerate(frames):
        if not commit:
            continue
        pages = snapshot_upto(idx)
        dbpath = os.path.join(tmp, f"snap.db")
        with open(dbpath, "wb") as f:
            n = max(pages)
            for i in range(1, n + 1):
                f.write(pages.get(i, b"\x00" * pgsz))
        con = sqlite3.connect(dbpath)
        tx = con.execute("select max(tx) from txlog").fetchone()[0]
        if tx == 47:
            row = con.execute(
                "select committed_ms, hex(nonce), payload from attachments "
                "where thread_id=17 and revision=4").fetchone()
            if row:
                best = (idx, tx, row)
        con.close()

idx, tx, (committed_ms, nonce_hex, payload) = best
print(f"snapshot at commit frame {idx} tx={tx} committed_ms={committed_ms}")

key = hashlib.sha256(f"{android_id}:17:4:{committed_ms}".encode()).digest()
aad = b"thread=17;revision=4"
nonce = bytes.fromhex(nonce_hex)
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
pt = AESGCM(key).decrypt(nonce, payload, aad)

z = zipfile.ZipFile(io_bytes := __import__("io").BytesIO(pt))
name = [n for n in z.namelist() if n.endswith("handoff.txt")][0]
print(z.read(name).decode())
