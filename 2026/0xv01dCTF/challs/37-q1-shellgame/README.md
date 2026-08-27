# q1 — Shellgame

- **Category:** Pwn
- **Points:** 425
- **Solves:** 16
- **Difficulty:** -
- **URL:** https://0xv01d-ctf.xyz/challenges/98

## Description
# q1 — Shellgame (pwn)

| | |
|---|---|
| Port | 20001 |
| Points (suggested) | 100 |
| Files | `chall` |
| Difficulty | Medium |

**EN:** The gatekeeper of V0ID only opens for a very specific pair of gifts:
`0xdeadbeef` and `0xcafebabe`. Overflow the guard's stack and hand them over
in exactly the right order. There is a `win()` that will drop you a shell —
but it needs arguments.

`nc 35.192.106.100 20001`

**AR:** حارس البوابة ما بيفتح إلا بهدية محددة: `0xdeadbeef` و `0xcafebabe`.
افعل الفيضان على الـ stack وسلمه الهدايا بالترتيب الصحيح — في دالة `win()`
بتعطيك شيل، بس محتاجة وسائط.

## Files
- `chall` — 64-bit ELF (NX, no PIE, no canary)


## Connection
nc 35.192.106.100 20001

## Files
- `q1-shellgame-player.zip`

## Instance
-

## Hints
None

<!-- Solve → write SOLVE.md here with the flag on top + method. -->
