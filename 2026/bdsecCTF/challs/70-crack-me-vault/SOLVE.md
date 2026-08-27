**Flag:** `BDSEC{c0nTr0L_fl0w_1s_4_l13_bUt_bYt3c0d3_d03s_n0t}`

**TL;DR** A tiny "bytecode VM" (4 opcodes, decoded by XOR with a rolling key) checks a 50-char flag. The verify opcode compares a per-char transform of the input to a target table. Invert it.

**Find** opcodes = `byte[bc] ^ r10` (r10: 0xa5,0xb6,0xc7,0xd8). op 0x37=transform 50 chars, op 0x11=len==50, op 0x6b=compare, op 0xe0=grant. Transform (input idx i):
`out = ((0xb*i ^ 0x17) + rol8(in[i] ^ (0x41+0x1d*i), (i%7)+1)) & 0xff`, stored at `(0x11*i)%50` (bijection). Compare: `out[(0x11*i)%50] == target[i] ^ (0x44+0xd*i)` for i<50.

**Solve** Per char: `in[i] = ror8((target[i]^(0x44+0xd*i)) - (0xb*i^0x17), (i%7)+1) ^ (0x41+0x1d*i)`. target @0x22c0 (50 B). See solver.py. Verified: "Access granted".
