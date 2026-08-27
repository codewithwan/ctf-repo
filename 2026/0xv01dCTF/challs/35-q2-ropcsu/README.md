# q2 — RopCSU

- **Category:** Pwn
- **Points:** 450
- **Solves:** 11
- **Difficulty:** -
- **URL:** https://0xv01d-ctf.xyz/challenges/99

## Description
# q2 — RopCSU (pwn)

| | |
|---|---|
| Port | 20002 |
| Points (suggested) | 250 |
| Files | `chall`, `libc.so.6` |
| Difficulty | Hard |

**EN:** No `win()`. No leaks. The binary only offers `puts` and `read`.
The libc is in your hands — you just have to find it at runtime. The
`__libc_csu_init` gadgets are waiting to call anything you point them at.
Two-stage: leak, then land.

`nc 35.192.106.100 20002`

**AR:** ما في `win()`. ما في أي تسريب. الباينري ما يعطيك غير `puts` و `read`.
الـ libc بين إيديك — بس لازم تلقاه وقت التشغيل. كيدجيتات `__libc_csu_init`
مستنية أي شي توجّهها له. مرحلتين: تسريب، ثم إصابة.

## Files
- `chall` — 64-bit ELF (NX, no PIE, no canary)
- `libc.so.6` — glibc 2.39 (the exact one on the server)


## Connection
nc 35.192.106.100 20002

## Files
- `q2-ropcsu-player.zip`

## Instance
-

## Hints
None

<!-- Solve → write SOLVE.md here with the flag on top + method. -->
