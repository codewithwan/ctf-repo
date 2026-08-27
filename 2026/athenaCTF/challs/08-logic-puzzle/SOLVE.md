# Logic Puzzle — SOLVED

**Magic input:** `1337`  ·  **Flag:** `athena{logic_puzz1e_4c7b}`

- **Category:** REV  ·  ELF x86-64 PIE, stripped. Static solve (ga perlu dijalanin).

## Reverse (main @ 0x11a0)
1. `argc==2` else exit(1).
2. `n = strtol(argv[1], NULL, 10)`.
3. Cek: `n*(n-1) == 0x1b4178 (1786232)` else exit(0) diam.
   Solve `n²−n−1786232=0` → `n = (1+√7144929)/2 = (1+2673)/2 = 1337`.
4. Bangun flag: seed `state = n = 1337`, tiap byte:
   ```
   state = (state*0x5851f42d4c957f2d + 0x14057b7ef767814f) mod 2^64   # LCG (PCG constants)
   ks    = (state >> 33) & 0xff
   flag[i] = ks XOR enc[i]     # enc = 25 byte di .rodata @ 0x2010
   ```
5. Integritas: FNV-1a-ish, `cmp eax, 0x2f4b2947` → cocok (verified).
6. `puts(flag); exit(1337)`.

## enc bytes (.rodata @ 0x2010, 25B)
`68 61 44 dd 7d 01 d0 01 e2 9c ad 16 6c ef e0 f9 cc e4 a9 67 df c1 7a 23 5c`

## Run asli
`./logic_puzzle.bin 1337` → `athena{logic_puzz1e_4c7b}`

Solver: [solve.py](solve.py)
