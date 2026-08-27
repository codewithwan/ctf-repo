# q3 — The Vault

**Status:** solved

**Flag:** `0xV01D{d825e0958f7f90c4ee3d0738}` (recovered, verified against remote — not submitted to scoreboard)

**Technique tags:** pwn, format string, canary/PIE/libc leak, ret2libc, full RELRO

**Signals:** every mitigation on (PIE, canary, full RELRO, NX); `printf(buf)` after `fgets(rsp, 0x80, stdin)` gives one format-string round; a second `read(0, rsp, 0x200)` overflows the 0x90 frame (canary at buffer+0x88, saved RIP at +0x98); provided glibc 2.39 matches the server.

**Failed approaches:** the binary has no pop-rdi gadget and no CSU, so the ROP must jump straight into libc gadgets (libc base is leaked); long positional format probes were flaky against the service (transient literal echoes) — keep the leak format short ("%23$p.%25$p.%29$p") and retry.

**Verification:** leak round: %23$p=canary, %25$p=PIE+0x1147 (saved RIP), %29$p=libc+0x2a1ca (return after `call rax` of main in __libc_init_first, verified by disassembling the provided libc and matching low 12 bits); overflow round with ret-aligned chain `ret; pop rdi; binsh; system` spawns a shell and `cat /home/ctf/flag.txt` prints the flag.

**Reusable takeaway:** For a single-round format-string leak, map the buffer position first (send a marker, find `%6$p`), then leak canary/PIE/libc in one short positional format; identify libc stack pointers by disassembling __libc_start_main/__libc_init_first and matching the low 12 bits of the return address after `call main` (0x2a1ca in glibc 2.39).

## Method
- Round 1: `%23$p.%25$p.%29$p` -> canary, PIE base, libc base.
- Round 2: overflow at 0x88 with canary; ROP = binary `ret` (alignment) + libc `pop rdi; ret` + `/bin/sh` + `system`.

## Solve
`solver.py` performs the leak and overflow against `nc 35.192.106.100 20003` and cats the flag.
