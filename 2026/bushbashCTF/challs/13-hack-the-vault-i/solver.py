#!/usr/bin/env python3

from pwn import remote

password = b"th3M0ssM4ni5h3re,y0uc4ntcatchm3"

r = remote("34.40.133.67", 7776)
r.sendline(password)
print(r.recvall(timeout=5).decode(errors="replace"))
