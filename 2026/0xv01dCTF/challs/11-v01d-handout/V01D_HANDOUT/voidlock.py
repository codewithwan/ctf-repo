#!/usr/bin/env python3
# =====================================================================
#  V O I D L O C K   v3.1
# =====================================================================
import hashlib

E     = 5
DELTA = 0x5641_4C55_45_5F_44454C5441_1337

CAPSULE_MAGIC = b"0xV0ID//SEAL-I//"
CAPSULE_NOISE = 208


def seal_one(capsule: bytes, n: int) -> tuple:
    m1 = int.from_bytes(capsule, "big")
    m2 = m1 + DELTA
    return pow(m1, E, n), pow(m2, E, n)

LCG_A = 0xB1F5_2C3D_9A47_E60B_44D9_7C21_5E38_0FA3
LCG_B = 0x7E19_D06C_3B82_F5A4_10CE_2947_8DB6_A5F1
TRUNC = 96
LEAKS = 8


def seal_two(p: int, x0: int) -> tuple:
    a, b = LCG_A % p, LCG_B % p
    x, leak = x0 % p, []
    for _ in range(LEAKS):
        leak.append(x >> TRUNC)
        x = (a * x + b) % p
    return leak, x

LENGTHS = (19, 21, 23)
MERSENNE_FACTORS = {
    19: (524287,),
    21: (7, 127, 337),
    23: (47, 178481),
}


def gf2_mulmod(a: int, b: int, mod: int, n: int) -> int:
    """Carry-less multiply of two GF(2) polys, reduced mod `mod` (deg n)."""
    r = 0
    while b:
        if b & 1:
            r ^= a
        b >>= 1
        a <<= 1
        if a >> n & 1:
            a ^= mod
    return r


def gf2_powmod(base: int, exp: int, mod: int, n: int) -> int:
    r, base = 1, base % (1 << n)
    while exp:
        if exp & 1:
            r = gf2_mulmod(r, base, mod, n)
        base = gf2_mulmod(base, base, mod, n)
        exp >>= 1
    return r


def is_primitive(taps: int, n: int) -> bool:
    """taps is the n-bit tap mask; char. poly is x^n + sum taps_i x^i."""
    if not taps & 1:
        return False
    poly = taps | (1 << n)
    order = (1 << n) - 1
    if gf2_powmod(2, order, poly, n) != 1:
        return False
    return all(gf2_powmod(2, order // q, poly, n) != 1
               for q in MERSENNE_FACTORS[n])


def derive_taps(seed: int, n: int, label: bytes) -> int:
    """Deterministically grow a primitive tap mask from the seal-II seed."""
    xof = hashlib.shake_256(b"VOIDLOCK/TAPS/" + label + b"/" +
                            seed.to_bytes(16, "big")).digest(8192)
    for i in range(0, len(xof) - 4, 4):
        cand = (int.from_bytes(xof[i:i + 4], "big") & ((1 << n) - 1)) | 1
        if is_primitive(cand, n):
            return cand
    raise RuntimeError("no primitive polynomial found -- reroll the drop")


class LFSR:
    """Fibonacci LFSR. Output is the LSB, feedback is parity(state & taps)."""

    def __init__(self, taps: int, state: int, n: int):
        self.taps, self.state, self.n = taps, state % (1 << n), n
        if self.state == 0:
            raise ValueError("dead register")

    def clock(self) -> int:
        out = self.state & 1
        fb = bin(self.state & self.taps).count("1") & 1
        self.state = (self.state >> 1) | (fb << (self.n - 1))
        return out


def seal_three(seed: int, states: tuple, nbytes: int) -> bytes:
    regs = [LFSR(derive_taps(seed, n, lbl), st, n)
            for n, st, lbl in zip(LENGTHS, states, (b"ALPHA", b"BETA", b"GAMMA"))]
    out = bytearray()
    for _ in range(nbytes):
        byte = 0
        for _ in range(8):
            x1, x2, x3 = (r.clock() for r in regs)
            byte = (byte << 1) | (x1 & x2) ^ (x2 & x3) ^ x3
        out.append(byte)
    return bytes(out)


HEADER = (b"[0xV0ID // SECURE TRANSMISSION]\n"
          b"NODE   : V-7 (NULLSTAR)\n"
          b"CLASS  : OMEGA / EYES-ONLY\n"
          b"NOTICE : keystream is single-use, do not reissue seals\n"
          b"PAYLOAD: ")
FOOTER = b"\n[EOT]\n"


def main():
    from _seals import RSA_P, RSA_Q, PRIME_P, NOISE, LCG_X0, LFSR_STATES, FLAG

    n = RSA_P * RSA_Q
    capsule = CAPSULE_MAGIC + NOISE + PRIME_P.to_bytes(16, "big")
    assert len(capsule) == 16 + CAPSULE_NOISE + 16
    c1, c2 = seal_one(capsule, n)

    leak, seed = seal_two(PRIME_P, LCG_X0)

    pt = HEADER + FLAG + FOOTER
    ks = seal_three(seed, LFSR_STATES, len(pt))
    ct = bytes(a ^ b for a, b in zip(pt, ks))

    print("=== SEAL I / THE ECHO ===")
    print(f"n     = {n}")
    print(f"e     = {E}")
    print(f"delta = {DELTA}")
    print(f"c1    = {c1}")
    print(f"c2    = {c2}")
    print()
    print("=== SEAL II / THE DRIFT ===")
    print(f"a     = {LCG_A}")
    print(f"b     = {LCG_B}")
    print(f"leak  = {leak}")
    print()
    print("=== SEAL III / THE STATIC ===")
    print(f"ct    = {ct.hex()}")


if __name__ == "__main__":
    main()
