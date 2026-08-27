#!/usr/bin/env python3
"""Negative Prompt Masterpiece — the flag sits in the PNG tEXt 'NegativePrompt' chunk."""
import struct, re

data = open("masterpiece.png", "rb").read()
i = 8
while i < len(data):
    ln = struct.unpack(">I", data[i:i + 4])[0]
    typ = data[i + 4:i + 8].decode("latin1")
    payload = data[i + 8:i + 8 + ln]
    if typ == "tEXt":
        key, _, val = payload.partition(b"\x00")
        print(key.decode(), "=>", val.decode())
    i += 12 + ln
