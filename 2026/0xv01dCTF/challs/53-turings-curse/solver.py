#!/usr/bin/env python3
"""
TURING'S CURSE (0xv01dCTF, rev 340) -- solver

Binary: challs/53-turings-curse/void (x86-64 ELF, stripped PIE)

Cipher: 3 rounds over a 32-byte state (payload = flag[7..38]):
    round = Sbox(a1) -> Permute(b2) -> GF-mix(c3) -> XOR roundkey(d4)

Layers:
  a1 (0x163f): byte substitution, S-box at 0x6500 (gen 0x1b40, seed 0x9e3779b97f4a7c15)
  b2 (0x1805): byte permutation P at 0x64e0 (gen 0x1b40, seed 0xd1b54a32d192ed03)
               state'[i] = state[P[i]]
  c3 (0x1752): per-4-byte-group GF(2^8)/0x11d linear mix; coefficients at 0x64c0
               built at 0x12b5: A[j][i] = exp[0xff - log[(4+j)^i]] = 1/((4+j)^i)
               out[4g+j] = XOR_i A[j][i] * state[4g+i]   (GF mult)
  d4 (0x19bb): XOR 32-byte round key = LCG(0xa24baed4963ee407)[32k..32k+31]

Final state must equal expected bytes at rodata 0x2f80 (32 bytes).
Verified against the real binary via Unicorn for 21 random payloads.

Flag format: 0xV01D{payload} (40 chars, payload 32 printable bytes).
"""
import struct
from emulate import gen_table

# ---------------- GF(2^8) / 0x11d ----------------
def gfmul(a, b):
    r = 0
    for _ in range(8):
        if b & 1:
            r ^= a
        carry = a & 0x80
        a = (a << 1) & 0xff
        if carry:
            a ^= 0x1d
        b >>= 1
    return r & 0xff

def gf_inv(a):
    for v in range(1, 256):
        if gfmul(a, v) == 1:
            return v
    return 0

# ---------------- tables (as in the binary) ----------------
S = gen_table(0x9e3779b97f4a7c15, 0x100)          # 0x6500 S-box
P = gen_table(0xd1b54a32d192ed03, 0x20)           # 0x64e0 permutation
assert sorted(S) == list(range(256))
assert sorted(P) == list(range(32))

exp = bytearray(512)                               # 0x6700
x = 1
for i in range(255):
    exp[i] = x
    x = gfmul(x, 2)
for i in range(0x101):
    exp[0xff + i] = exp[i]
log = [0]*256                                      # 0x6600
for i in range(1, 256):
    log[exp[i]] = i

def lcg_fill(seed, n):                             # LCG at 0x12fe
    out = []
    s = seed
    M = 0xffffffffffffffff
    for _ in range(n):
        rax = (s << 0xd) & M
        rax ^= s
        rdx = rax >> 0x7
        rax ^= rdx
        rdx = (rax << 0x11) & M
        rdx ^= rax
        out.append(rdx & 0xff)
        s = rdx
    return bytes(out)

lcg = lcg_fill(0xa24baed4963ee407, 96)
rk = [lcg[32*k:32*k+32] for k in range(3)]
mix_tab = bytearray(16)                            # 0x64c0 (0x12b5 construction)
for b in range(4):
    for a in range(4):
        v = (4 + a) ^ b
        mix_tab[4*b + a] = 0 if v == 0 else exp[0xff - log[v]]
mix_tab = bytes(mix_tab)

EXPECTED = bytes.fromhex("f2445b07a777f4aba36bd35b832beb2b5d825ff488552d758990e2b11bb5cae7")

# ---------------- forward layers ----------------
def sbox(st):
    return bytes(S[b] for b in st)

def perm(st):
    return bytes(st[P[i]] for i in range(32))

def mix(st):
    out = bytearray(32)
    for g in range(8):
        for j in range(4):
            acc = 0
            for i in range(4):
                t = mix_tab[4*j + i]
                x = st[4*g + i]
                if t and x:
                    acc ^= exp[log[t] + log[x]]
            out[4*g + j] = acc
    return bytes(out)

def xorkey(st, k):
    return bytes(a ^ b for a, b in zip(st, rk[k]))

def vm(payload):
    st = bytes(payload)
    for k in range(3):
        st = xorkey(mix(perm(sbox(st))), k)
    return st

# ---------------- inverse layers ----------------
def sbox_inv(st):
    return bytes(S.index(b) for b in st)

def perm_inv(st):
    inv = [0]*32
    for i, v in enumerate(P):
        inv[v] = i
    return bytes(st[inv[i]] for i in range(32))

def mix_inv(st):
    # block-diagonal 4x4 GF matrix per group; invert each 4x4 block analytically
    A = [[mix_tab[4*j + i] for i in range(4)] for j in range(4)]
    Ainv = [[0]*4 for _ in range(4)]
    # Gaussian elimination over GF(256)
    aug = [row[:] + [1 if i == j else 0 for j in range(4)] for i, row in enumerate(A)]
    for col in range(4):
        piv = next(r for r in range(col, 4) if aug[r][col] != 0)
        aug[col], aug[piv] = aug[piv], aug[col]
        invp = gf_inv(aug[col][col])
        aug[col] = [gfmul(v, invp) for v in aug[col]]
        for r in range(4):
            if r != col and aug[r][col]:
                f = aug[r][col]
                aug[r] = [a ^ gfmul(f, b) for a, b in zip(aug[r], aug[col])]
    Ainv = [row[4:] for row in aug]
    out = bytearray(32)
    for g in range(8):
        for j in range(4):
            acc = 0
            for i in range(4):
                acc ^= gfmul(Ainv[j][i], st[4*g + i])
            out[4*g + j] = acc
    return bytes(out)

def solve():
    st = EXPECTED
    for k in (2, 1, 0):
        st = bytes(a ^ b for a, b in zip(st, rk[k]))   # undo d4
        st = mix_inv(st)                                # undo c3
        st = perm_inv(st)                               # undo b2
        st = sbox_inv(st)                               # undo a1
    return st

if __name__ == '__main__':
    payload = solve()
    print("payload:", payload.hex())
    print("printable:", all(0x20 <= b < 0x7f for b in payload))
    print("repr:", repr(payload))
    flag = "0xV01D{" + payload.decode('latin1') + "}"
    print("flag:", flag)
    print("vm(payload) == EXPECTED:", vm(payload) == EXPECTED)
