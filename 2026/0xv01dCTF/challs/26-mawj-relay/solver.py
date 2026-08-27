#!/usr/bin/env python3
"""Mawj Relay — decrypt the recorded push route in assets/push_routes.bin.

The APK is a trap (fake dex, decoy flags). The real payload is an XOR-encrypted
JSON route record: key = sha256(action + ':' + label) =
sha256("com.void.echo.PUSH:EchoPush") from the manifest + strings.xml hint,
applied cyclically starting at byte offset 9 after the VPUSH1 header.
"""
import hashlib
import zipfile


def main():
    with zipfile.ZipFile("mawj.zip") as z:
        z.extractall()
    with zipfile.ZipFile("kizcjo.apk") as z:
        z.extractall("apk")

    key = hashlib.sha256(b"com.void.echo.PUSH:EchoPush").digest()
    blob = open("apk/assets/push_routes.bin", "rb").read()
    assert blob[:6] == b"VPUSH1"
    ct = blob[9:]  # VPUSH1 + 3 header bytes
    plain = bytes(b ^ key[i % len(key)] for i, b in enumerate(ct))
    print(plain.decode())


if __name__ == "__main__":
    main()
