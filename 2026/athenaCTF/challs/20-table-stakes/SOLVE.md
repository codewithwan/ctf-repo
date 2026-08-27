# Table Stakes — Athena CTF 2026 (REV, 175)

**Flag:** `athena{st4tic_str1ngs_b0rn}`

## Summary
`challenge.bin` is a stripped x86-64 Linux ELF. `main` (at `0x40129f`) verifies
`argv[1]` by transforming it and `memcmp`-ing the result against an embedded 27-byte
target. The answer is never printed — recovered by inverting the transform statically.

## Check logic (main @ 0x40129f)
1. `strlen(argv[1]) == 0x1b` (27) — else "Incorrect."
2. Picks a transform from a function-pointer TABLE (the "Table Stakes" hint):
   - `idx = 5 % 3 = 2` (constant `5` at `[rsp+0x8c]`, `idiv 3`).
   - Table at `.data.rel.ro` `0x403df0` = `{0x4011e0, 0x40121d, 0x40125b}`.
   - So it calls **`table[2] = 0x40125b`** on `argv[1]` (len 27), output at `rsp+0x40`.
3. `memcmp(output, 0x402020, 0x1b)` == 0 → "Correct!".

The other two table entries (0x4011e0 add/xor, 0x40121d ror/xor) and the
strings `JBSWY3DPEBLW64TMMQ======` ("Hello World" b32), `VGVzdCBGbGFn` ("Test Flag" b64),
and the byte blob at `0x2070` are **decoys** — never executed.

## The transform (forward), function @ 0x40125b
```
key = 0x5f
for i in range(27):
    out[i] = rol(in[i], 3) ^ (key & 0xff)   # rol cl,3 ; xor ecx,eax
    key = (key * 0x6b + 0x2f) & 0xffffffff   # imul eax,0x6b ; add eax,0x2f
```
`rol` is an 8-bit rotate-left-by-3. `key` is a 32-bit LCG; only its low byte is used.

## Target bytes (@ .rodata 0x402020, 27 bytes)
```
54 47 38 b3 c4 a7 c8 bb 2c 55 88 63 fc 46 58 13
2c 8d a8 83 8c 36 60 c1 7c 67 60
```

## Inversion
```
in[i] = ror(target[i] ^ (key & 0xff), 3)   # undo xor, then undo rol => ror by 3
```
Same key schedule (key=0x5f, key=key*0x6b+0x2f).

## Verification
Re-applying the forward transform to the recovered flag reproduces the embedded
target exactly (`forward match: True`). See `solve.py`.

Confidence: **high** — length 27 matches the `0x1b` check and the forward re-encode
byte-for-byte matches the embedded `memcmp` target.
