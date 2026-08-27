"""Faithful x86-level model of TURING'S CURSE cipher.

Memory layout during VM (relative to state base B = [rsp+0xd0]):
    mem[0x00:0x20]  state        ([rsp+0xd0..0xef])
    mem[0x20:0x40]  shadow       ([rsp+0xf0..0x10f])  -- fake flag round1, else prev b2/c3 leftovers
    mem[0x40:0x80]  input region ([rsp+0x110..0x14f]) -- "0xV01D{...}" + NULs
    mem[0x80:]      stack (zero-filled assumption)
"""
import struct
from emulate import gen_table

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

S = gen_table(0x9e3779b97f4a7c15, 0x100)
P = gen_table(0xd1b54a32d192ed03, 0x20)

exp = bytearray(512)
x = 1
for i in range(255):
    exp[i] = x
    x = gfmul(x, 2)
for i in range(0x101):
    exp[0xff + i] = exp[i]
log = [0]*256
for i in range(1, 256):
    log[exp[i]] = i

def lcg_fill(seed, n):
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
# mix table at 0x64c0 built at 0x12b5: out[4b+a] = 6700[0xff - 6600[(4+a)^b]]
# = exp[0xff - log[(4+a)^b]]  (i.e. GF inverse of (4+a)^b)
mix_tab = bytearray(16)
for b in range(4):
    for a in range(4):
        v = (4 + a) ^ b
        if v == 0:
            mix_tab[4*b + a] = 0
        else:
            mix_tab[4*b + a] = exp[0xff - log[v]]
mix_tab = bytes(mix_tab)

FAKE = b"0xV01D{K1ll_7h3_CUR53_57R1NG}" + bytes(3)  # [rsp+0xf0..0x10f]

def make_mem(payload):
    """payload = 32 bytes (input[7..38]). Returns 0x200-byte mem."""
    mem = bytearray(0x200)
    mem[0x00:0x20] = payload
    mem[0x20:0x40] = FAKE
    full = b"0xV01D{" + payload + b"}"
    mem[0x40:0x68] = full
    return mem

def op_a1(mem):
    for i in range(0x20):
        mem[i] = S[mem[i]]

def op_b2(mem):
    # out[j] = state[P[j]] for j in 0..31 (0x64e0 permutation); write to shadow, copy back
    for j in range(0x20):
        mem[0x20 + j] = mem[P[j]]
    mem[0x00:0x20] = mem[0x20:0x40]

def op_c3(mem):
    out = bytearray(32)
    for g in range(8):
        for j in range(4):
            acc = 0
            for i in range(4):
                t = mix_tab[4*j + i]
                x = mem[4*g + i]
                if t == 0 or x == 0:
                    continue
                acc ^= exp[log[t] + log[x]]
            out[4*g + j] = acc
    mem[0x20:0x24] = out[0:4]           # [rsp+0xf0] dword write
    mem[0x00:0x20] = out                # state groups overwritten with dword
    # note: out[0:4] dword written to shadow; state = out (byte-for-byte the dword dup)

def op_d4(mem, k):
    for i in range(0x20):
        mem[i] ^= rk[k][i]

def vm(payload, trace=False):
    mem = make_mem(payload)
    for k in range(3):
        op_a1(mem)
        op_b2(mem)
        op_c3(mem)
        op_d4(mem, k)
    return bytes(mem[0:0x20])

if __name__ == '__main__':
    # test vs real binary: A*32 payload -> 369c618c884f014d1eb1b015ca6716b906e5fd323de1e4f0b4b7a9e2425b0eaa
    p = b'A' * 32
    print("vm:", vm(p).hex())
    print("want: 369c618c884f014d1eb1b015ca6716b906e5fd323de1e4f0b4b7a9e2425b0eaa")
