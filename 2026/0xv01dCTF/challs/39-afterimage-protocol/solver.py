#!/usr/bin/env python3
"""Afterimage Protocol — recover the 16-char identifier from the folded tape.

The validator folds a 320-entry instruction tape (index = (41 + 73k) % 320),
mixes each entry with the "afterimage" (8 bytes) and a splitmix-style
finalizer, feeds the result into an FNV-1a accumulator, and then dispatches
one of 7 bytecode ops that mutate the 16-byte input body.  The final check
compares the *mutated* buffer against a fixed 16-byte "afterimage tape", so
we compute the post-VM target, then invert the 320 ops in reverse.
"""
import struct

D = open('player/afterimage', 'rb').read()
OFF = 0x400000


def rd(va, n):
    return D[va - OFF:va - OFF + n]


MASK = (1 << 64) - 1
K = 0x9e3779b97f4a7c15
FNV_BASIS = 0xcbf29ce484222325
FNV_PRIME = 0x100000001b3

TAPE = [int.from_bytes(rd(0x4020a0 + i * 8, 8), 'little') for i in range(320)]
AFTERIMAGE = int.from_bytes(rd(0x402098, 8), 'little')
FINAL_TAPE = rd(0x402aa0, 16)


def finalize(x):
    x ^= x >> 30
    x = (x * 0xbf58476d1ce4e5b9) & MASK
    x ^= x >> 27
    x = (x * 0x94d049bb133111eb) & MASK
    x ^= x >> 31
    return x


def rol64(x, n):
    n &= 63
    return ((x << n) | (x >> (64 - n))) & MASK


def ror8(x, n):
    n &= 7
    return ((x >> n) | (x << (8 - n))) & 0xff


def rol8(x, n):
    n &= 7
    return ((x << n) | (x >> (8 - n))) & 0xff


# ---- derive the op tape (input-independent) and the FNV state ----
steps = []
state = FNV_BASIS
for k in range(320):
    rbp = (0x29 + 0x49 * k) % 0x140
    x = (rbp * 0xd6e8feb86659fd93) & MASK
    x ^= AFTERIMAGE
    x ^= 0xa17e5eedc0dec0de
    x = (x + K) & MASK
    mixed = TAPE[rbp] ^ finalize(x)
    for b in mixed.to_bytes(8, 'little'):
        state ^= b
        state = (state * FNV_PRIME) & MASK
    idx = (((0x1d * rbp - 0x59) ^ (mixed & 0xffffffff)) & 0xff) % 7
    op = 6 if idx == 0 else (4, 3, 2, 1, 0, 5)[idx - 1]  # jump table order
    lo = (mixed >> 8) & 0xf
    ecx = (mixed >> 16) & 0xff
    r14 = (mixed >> 24) & 0xff
    edx = (mixed >> 32) & 0xffffffff
    steps.append((op, rbp, mixed, lo, ecx, r14, edx))


OP0_K = 0x9e3779b185ebca87   # op0's xor constant (differs from K!)


def apply_op(b, s):
    op, rbp, mixed, lo, ecx, r14, edx = s
    if op == 0:                       # Feistel-ish 8+8 byte transform
        in_lo = int.from_bytes(b[0:8], 'little')
        in_hi = int.from_bytes(b[8:16], 'little')
        rdx = ((edx ^ 0xa5c39e71) | (edx << 32))
        rdx = (rdx + ((rbp * FNV_PRIME) & MASK) + in_hi) & MASK
        rdx = rol64(rdx, (r14 % 63) + 1)
        factor = (2 * (lo | 1)) ^ OP0_K
        out_hi = ((factor * in_hi) ^ in_lo ^ rdx) & MASK
        b[0:8] = in_hi.to_bytes(8, 'little')
        b[8:16] = out_hi.to_bytes(8, 'little')
    elif op == 1:                     # b[lo] = b[lo]*(edx|1) + dh
        b[lo] = (((edx | 1) & 0xff) * b[lo] + ((mixed >> 40) & 0xff)) & 0xff
    elif op == 2:                     # swap b[lo] <-> b[ecx & 0xf]
        d2 = ecx & 0xf
        b[lo], b[d2] = b[d2], b[lo]
    elif op == 3:                     # rol b[lo] by (r14 & 7) or 1
        n = r14 & 7
        b[lo] = rol8(b[lo], n or 1)
    elif op == 4:                     # b[lo] += dl
        b[lo] = (b[lo] + (edx & 0xff)) & 0xff
    elif op == 5:                     # b'[i] = b[(rot + i) & 0xf], rot = r14&0xf or 1
        rot = (r14 & 0xf) or 1
        old = bytes(b)
        for i in range(16):
            b[i] = old[(rot + i) & 0xf]
    else:                             # b[lo] ^= dl
        b[lo] ^= edx & 0xff


def apply_inv(b, s):
    op, rbp, mixed, lo, ecx, r14, edx = s
    if op == 0:
        in_hi = int.from_bytes(b[0:8], 'little')
        new_hi = int.from_bytes(b[8:16], 'little')
        rdx = ((edx ^ 0xa5c39e71) | (edx << 32))
        rdx = (rdx + ((rbp * FNV_PRIME) & MASK) + in_hi) & MASK
        rdx = rol64(rdx, (r14 % 63) + 1)
        factor = (2 * (lo | 1)) ^ OP0_K
        in_lo = (new_hi ^ ((factor * in_hi) & MASK) ^ rdx) & MASK
        b[0:8] = in_lo.to_bytes(8, 'little')
        b[8:16] = in_hi.to_bytes(8, 'little')
    elif op == 1:
        e = (edx | 1) & 0xff
        b[lo] = (((b[lo] - ((mixed >> 40) & 0xff)) & 0xff) * pow(e, -1, 256)) & 0xff
    elif op == 2:
        d2 = ecx & 0xf
        b[lo], b[d2] = b[d2], b[lo]
    elif op == 3:
        n = r14 & 7
        b[lo] = ror8(b[lo], n or 1)
    elif op == 4:
        b[lo] = (b[lo] - (edx & 0xff)) & 0xff
    elif op == 5:
        rot = (r14 & 0xf) or 1
        old = bytes(b)
        for i in range(16):
            b[i] = old[(i - rot) & 0xf]
    else:
        b[lo] ^= edx & 0xff


# post-VM target: FINAL_TAPE[i] ^ finalize(i*K ^ fnv_after ^ K) & 0xff
rsi = state ^ AFTERIMAGE
target = bytearray(
    FINAL_TAPE[i] ^ (finalize(((((i * K) & MASK) ^ rsi) + K) & MASK) & 0xff)
    for i in range(16)
)

# invert the tape to get the original identifier body
buf = bytearray(target)
for s in reversed(steps):
    apply_inv(buf, s)

# sanity: forward run must reproduce the target, and bytes must be alnum
chk = bytearray(buf)
for s in steps:
    apply_op(chk, s)
assert bytes(chk) == bytes(target), 'forward re-run mismatch'
ident = bytes(buf)
assert all(0x30 <= c <= 0x39 or 0x41 <= c <= 0x5a or 0x61 <= c <= 0x7a for c in ident), ident

print('identifier:', ident.decode())
print('FLAG: 0xV01D{' + ident.decode() + '}')
