#!/usr/bin/env python3

import socket
import time
import select
from pathlib import Path

ct = bytearray(Path("extracted/message.ct").read_bytes())

known_user = bytes.fromhex("000000000345f8d381aa95e4ef70279a")
premium_user = bytes.fromhex("000000000234f923643a9520ef762777")

# CBC bit flip: changing C0 changes plaintext block P1, where the user id lives.
for i, (a, b) in enumerate(zip(known_user, premium_user)):
    ct[i] ^= a ^ b

flush_block = Path("extracted/message.ct").read_bytes()

s = socket.create_connection(("34.40.133.67", 6001), timeout=10)
s.sendall(bytes(ct) + flush_block)
s.setblocking(False)

end = time.time() + 35
buf = b""
while time.time() < end:
    readable, _, _ = select.select([s], [], [], 1)
    if readable:
        data = s.recv(4096)
        if not data:
            break
        buf += data

print(buf.decode(errors="replace"))
