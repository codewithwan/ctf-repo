# q2 — RopCSU

**Status:** solved

**Flag:** `0xV01D{cc1033e9d2a8baefc04fb019}` (recovered, verified against remote — not submitted to scoreboard)

**Technique tags:** pwn, ret2csu, ret2libc, no-PIE, partial RELRO, two-stage

**Signals:** no win(), no canary, no PIE, only puts+read PLT; provided libc.so.6 (glibc 2.39) is the exact server libc; __libc_csu_init pop/call gadgets present at 0x4011e4/0x4011ef; main() frame is `sub rsp,0x58` with NO push rbp.

**Failed approaches:** first attempt used offset 0x60 (assuming a saved rbp) and r12=PLT — both crash: the frame has no saved rbp (offset is 0x58) and CSU `call [r12+8*rbx]` needs r12 to be the GOT slot (address of the function pointer), not the PLT entry.

**Verification:** stage 1 ret2csu leaks puts@got and returns to main (prompt repeats); stage 2 ret2csu calls read(0, bss, 8) then system(bss) -> shell; `cat /home/ctf/flag.txt` prints the flag verbatim.

**Reusable takeaway:** For csu-based calls, r12 must hold the GOT entry address because the gadget does `call [r12 + 8*rbx]`; and confirm the actual frame layout (is there a push rbp?) by disassembling before computing the RIP offset.

## Method
- main: setvbuf, puts(prompt), read(0, rsp, 0x200) -> overflow at offset 0x58, ret.
- Stage 1: csu(puts@got, puts@got, 0, 0) leak libc puts; loop exits via rbp=8; ret to main.
- Stage 2: csu(read@got, 0, bss, 8) then pop rdi; bss; system -> shell.

## Solve
`solver.py` runs the two-stage chain against `nc 35.192.106.100 20002` and cats the flag.
