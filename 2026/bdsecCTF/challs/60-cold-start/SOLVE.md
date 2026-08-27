**Flag:** `BDSEC{th3_k3y_w4s_s0m3wh3r3_1n_16_m1ll10n}`

**TL;DR** Input = 6-hex "activation seed" (≤0xffffff = 24-bit). It's fed through a 96-round murmur/FNV-ish mixer producing a 96-dword array; 3 derived dwords must equal fixed targets. 24-bit space ⇒ brute force in C.

**Find** strlen==6, isxdigit, strtoul base16 → seed ≤ 0xffffff. 96-iter loop (rsi<0x60) mixes seed with a 256-dword table @0x2140 and evolving state (edx/edi/r8/r9/r10/r11). Final combine of arr[47,11,83,68,23,55,7,91] → checks: `cx==0x9c8c`, `eax==0x91e50c54`, `edx==0xc2e4f8bd` → success.

**Solve** Reimplement the exact round + final combine in C, brute 0..0xffffff (7s) → seed `0x93c7a4`. Feed `93c7a4` → binary prints flag. See brute.c.
