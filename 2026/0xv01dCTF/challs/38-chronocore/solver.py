#!/usr/bin/env python3
"""ChronoCore — recover the 37-char flag from the 37-step byte check.

The validator's phase-1 "time shuffle" writes an isolated stack buffer (dead
writes; never read by the check).  Phase 2 walks a permutation table P
(0x2140) over the input and, for each step rdx, enforces one byte equation
against expected bytes E (0x2040) with a carried state byte r (init 0x42):

  b = input[P[rdx]]
  v = rol32((T1[rdx] + b + 17*rdx) ^ 0x9e3779b9, T2[rdx])
  v = v * 0x45d9f3b + rdx + 0x27100001
  f = (v >> ((rdx & 3) * 8)) & 0xffffffff
  ((f + b) ^ T3[rdx] ^ r) & 0xff == E[rdx]
  r' = (b + rdx + (((f + b) & 0xff) ^ T3[rdx] ^ r)) & 0xff

Each input byte is constrained exactly once (P is a permutation), so the
check is solved byte-by-byte in rdx order.
"""
import string

D = open('player/chronocore', 'rb').read()


def table(va):
    return D[va:va + 37]


P = table(0x2140)   # input index permutation
T1 = table(0x2100)
T2 = table(0x2080)  # rol counts
T3 = table(0x20c0)
E = table(0x2040)   # expected low bytes

M32 = 0xffffffff
K = 0x9e3779b9
MUL = 0x45d9f3b


def step(b, rdx, r, eax):
    v = ((T1[rdx] + b + 17 * rdx) ^ eax) & M32          # eax = previous step's post-lea carry
    rol = ((v << (T2[rdx] & 31)) | (v >> (32 - (T2[rdx] & 31)))) & M32
    v = (rol * MUL) & M32
    v = (v + rdx + 0x27100001) & M32                    # next step's eax carry
    f = v >> ((rdx & 3) * 8)
    cl = (((f + b) & 0xff) ^ T3[rdx] ^ r) & 0xff
    r2 = (b + rdx + (((f + b) & 0xff) ^ T3[rdx] ^ r)) & 0xff
    return cl, r2, v


fixed = {i: c for i, c in enumerate(b"0xV01D{")}
fixed[36] = ord('}')

def solve():
    out = bytearray(37)
    r, eax = 0x42, K

    def rec(rdx):
        nonlocal r, eax
        if rdx == 37:
            yield bytes(out)
            return
        idx = P[rdx]
        if idx in fixed:
            b = fixed[idx]
            got, r2, e2 = step(b, rdx, r, eax)
            if got != E[rdx]:
                return                      # dead branch: fixed byte mismatch
            r, eax = r2, e2
            out[idx] = b
            yield from rec(rdx + 1)
            return
        cands = []
        for b in range(256):
            got, _, _ = step(b, rdx, r, eax)
            if got == E[rdx]:
                cands.append(b)
        cands.sort(key=lambda b: (b not in string.printable.encode(), b))
        for b in cands:
            got, r2, e2 = step(b, rdx, r, eax)
            save_r, save_e = r, eax
            r, eax = r2, e2
            out[idx] = b
            yield from rec(rdx + 1)
            r, eax = save_r, save_e

    for flag in rec(0):
        try:
            f = flag.decode()
        except UnicodeDecodeError:
            continue
        if f.startswith('0xV01D{') and f.endswith('}') and all(0x20 <= c < 0x7f for c in flag[7:36]):
            yield f


flags = list(solve())
good = [f for f in flags if all(c in (string.ascii_lowercase + string.digits + '_-') for c in f[7:36])]
pick = good[0] if good else flags[0]
print('solutions:', len(flags))
print('flag:', pick)
