# ChronoCore · rev

**Status:** solved
**Flag:** `0xV01D{vm_tr4c3s_l13_but_st4t3_t3lls}`

**Technique tags:** rev, x86-64, stripped, state-machine, byte-constraint, permutation-table, unicorn-emulation
**Signals:** stripped PIE ELF; prompts `chronocore> `; requires `0xV01D{` prefix and `}` suffix, total length 37; validator at 0x1390; phase-1 loop shuffles an isolated stack buffer (dead writes — "time shuffle" red herring); phase-2 walks input via permutation table at 0x2140 and enforces 37 byte equations against expected bytes at 0x2040 with two carried states.
**Verification:** Unicorn (canary patched out) runs the real validator: wrong inputs return 0, the recovered flag returns 1. Fixed prefix bytes (`0xV01D{`, `}`) also satisfy their steps in the model, confirming the state model matches the emulator.
**Reusable takeaway:** when a check is byte-sequential with carried state, extract the exact formula per step from the assembly (including registers clobbered across iterations — here `eax` was the previous step's post-`lea` value, not the raw `rol`), then solve byte-by-byte with DFS for ambiguous steps.
**Failed approaches:** phase-1 stack shuffle was initially treated as meaningful; it only writes an isolated buffer never read by the check. The first state model used a fixed xor constant, but `eax` is overwritten each iteration by the `rol`/`imul`/`lea` chain and carried into the next step's xor.
**TL;DR:** The 37-step check computes `cl = ((rol32((T1[rdx]+b+17*rdx)^eax, T2[rdx])*M + rdx + 0x27100001) >> ((rdx&3)*8) + b) ^ T3[rdx] ^ r` and requires it to equal `E[rdx]`; `eax` and the low byte `r` (init 0x42) carry between steps. Solving the 29 unknown body bytes yields the flag (2 solutions pass the binary; the intended one is the readable leetspeak flag).
