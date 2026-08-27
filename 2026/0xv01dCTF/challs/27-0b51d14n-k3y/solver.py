#!/usr/bin/env python3
"""0b51d14n_k3y — recover the AES-GCM secret from shard.db.

The APK leaks a leftover native source (libshard.c): key fragments
SKFRAG0..3 with order "seq=2,0,3,1". Strip the "SKFRAGn:" prefixes, join in
that order, SHA-256 it, and decrypt master_shard (AES-GCM, AAD = context).
"""
import hashlib
import re
import sqlite3
import zipfile

from Crypto.Cipher import AES


def main():
    with zipfile.ZipFile("obsidian_key.zip") as z:
        z.extractall()
    with zipfile.ZipFile("ob9k3x.apk") as z:
        z.extractall("apk")

    src = open("apk/libshard.c").read()
    frags = {int(m.group(1)): m.group(2)
             for m in re.finditer(r'sk_f(\d)\s*=\s*"SKFRAG\d:([^"]*)"', src)}
    order = [int(x) for x in re.search(r"seq=([\d,]+)", src).group(1).split(",")]
    key = hashlib.sha256("".join(frags[i] for i in order).encode()).digest()

    con = sqlite3.connect("apk/assets/shard.db")
    iv, tag, ct, aad = con.execute(
        "select iv, tag, ciphertext, context from shard where name='master_shard'").fetchone()
    c = AES.new(key, AES.MODE_GCM, nonce=bytes.fromhex(iv))
    c.update(aad.encode())
    print(c.decrypt_and_verify(bytes.fromhex(ct), bytes.fromhex(tag)).decode())


if __name__ == "__main__":
    main()
