import struct

# ---------------- SSE helpers (16-byte vectors as 8 x 16-bit words) ----------------
def w(bs):  # bytes -> words
    return list(struct.unpack('<8H', bytes(bs)))

def tobytes(wl):
    return bytes(struct.pack('<8H', *wl))

def punpcklwd(a, b):
    # a,b: 8 words each; result = a0,b0,a1,b1,a2,b2,a3,b3
    return [a[0], b[0], a[1], b[1], a[2], b[2], a[3], b[3]]

def punpckhwd(a, b):
    return [a[4], b[4], a[5], b[5], a[6], b[6], a[7], b[7]]

def paddd(a, b):
    # dword add: words pair as little-endian dwords
    ad = struct.unpack('<4I', tobytes(a))
    bd = struct.unpack('<4I', tobytes(b))
    return w(struct.pack('<4I', *[(x + y) & 0xffffffff for x, y in zip(ad, bd)]))

def pand_mask(a):
    return [x & 0xff for x in a]

def packuswb(a, b):
    out = []
    for x in a: out.append(max(0, min(255, x)))
    for x in b: out.append(max(0, min(255, x)))
    return bytes(out)

def gen_table(seed, count):
    """Faithful reimplementation of 0x1b40(rdi=dest, esi=count, rdx=seed)."""
    dest = bytearray(count)
    xmm3 = w(struct.pack('<4I', 0, 1, 2, 3))
    xmm9 = w(struct.pack('<4I', 0x10, 0x10, 0x10, 0x10))
    xmm8 = w(struct.pack('<4I', 4, 4, 4, 4))
    xmm7 = w(struct.pack('<4I', 8, 8, 8, 8))
    xmm6 = w(struct.pack('<4I', 0xc, 0xc, 0xc, 0xc))
    esi2 = count & ~0xf
    pos = 0
    while pos < esi2:
        xmm2 = xmm3[:]
        xmm3 = paddd(xmm3, xmm9)
        xmm4 = paddd(xmm2, xmm8)
        xmm1 = punpcklwd(xmm2, xmm4)
        xmm0 = punpckhwd(xmm2, xmm4)
        xmm4 = xmm1[:]
        xmm1 = punpcklwd(xmm1, xmm0)
        xmm4 = punpckhwd(xmm4, xmm0)
        xmm0 = xmm2[:]
        xmm2 = paddd(xmm2, xmm6)
        xmm0 = paddd(xmm0, xmm7)
        xmm1 = punpcklwd(xmm1, xmm4)
        xmm4 = xmm0[:]
        xmm0 = punpcklwd(xmm0, xmm2)
        xmm4 = punpckhwd(xmm4, xmm2)
        xmm2 = xmm0[:]
        xmm2 = punpckhwd(xmm2, xmm4)
        xmm0 = punpcklwd(xmm0, xmm4)
        xmm0 = punpcklwd(xmm0, xmm2)
        xmm1 = pand_mask(xmm1)
        xmm0 = pand_mask(xmm0)
        blk = packuswb(xmm1, xmm0)
        dest[pos:pos+16] = blk
        pos += 16
    # Fisher-Yates shuffle (0x1bfb..0x1c56)
    rdi = count
    r9 = count - 1
    r10 = 1
    rcx = seed & 0xffffffffffffffff
    r8 = dest
    while True:
        rax = rcx
        esi = r8[rdi - 1]
        rax = (rax << 13) & 0xffffffffffffffff
        rax ^= rcx
        rdx = rax
        rdx >>= 7
        rax ^= rdx
        rcx = rax
        rcx = (rcx << 17) & 0xffffffffffffffff
        rcx ^= rax
        rax = rcx
        rdx = rax % rdi
        j = rdx
        tmp = r8[j]
        r8[rdi - 1] = tmp
        rdi = r9
        r8[j] = esi
        if r10 == r9:
            break
        r9 -= 1
    return bytes(r8)

if __name__ == '__main__':
    S = gen_table(0x9e3779b97f4a7c15, 0x100)
    P = gen_table(0xd1b54a32d192ed03, 0x20)
    print("S-box perm of 0..255?", sorted(S) == list(range(256)))
    print("S[0:16]:", [hex(x) for x in S[:16]])
    print("P:", [hex(x) for x in P])
    print("P is perm of 0..31?", sorted(P) == list(range(32)))
