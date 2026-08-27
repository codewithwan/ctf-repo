#!/usr/bin/env python3

import socket

password = b"AAAAAAAAJ688aa_E"

s = socket.create_connection(("34.40.133.67", 7777), timeout=10)
s.sendall(password + b"\n")
s.settimeout(5)

out = b""
try:
    while True:
        chunk = s.recv(4096)
        if not chunk:
            break
        out += chunk
except TimeoutError:
    pass

print(out.decode(errors="replace"))
