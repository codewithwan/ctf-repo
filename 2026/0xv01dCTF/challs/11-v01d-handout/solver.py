#!/usr/bin/env python3
"""V01D Handout solver — Seal I (Franklin-Reiter), Seal II (truncated LCG), Seal III (LFSR)."""
import hashlib
import numpy as np
from fractions import Fraction

# ---------------- challenge data (transmission.txt) ----------------
N = int("25928782651320620641992939140254039773053786143820023022156108435673795888462270829259940673823214637262717952358987391353085730564901510124603705804524112129476757566788142657088664175065593801641965381026991405255727859541175048223240770122323050535833715088675068682271090820084603319348688347351380861828242704714087132514926072521191737125605753678645790120657253978542547752236110505793854886171416458968419171851938582488979266129737463791105500554112134356498730998376352918821416032348958045483800151660133625684914738099274709079396467282048633239278081191552849291204257984704422013322792106841287335460719")
E = 5
DELTA = 0x56414C55455F44454C54411337
C1 = int("2271166609354636919573347128840161371936229585863094230781200269193697434103766416960877947863137367309986938975665479588759510782654663865238207041844510373806887525535495510274789717076202255998760674528063535376982602045898972554740783752572007808625255837024569184071895615210635348690959062860007894570514343164562507439453606004265146656456457932347175386259112190734390287327994321167691079767562237904194404573437094738297816979714864588518384761278586142107820759294318139469385737698093641771095573359179821670180757583384120018468170963726551440086225358842440503171717002348714648811598284419231312422128")
C2 = int("21509286942876035740813203357561936979765841272579839022736609779635127483686155752043042270306807257492479689909872247694448834824737706970596168518041304670676582963323105074595769264935471267110127006490053258150836273217655012309996504529536284884763861961983138941430380931035377367474034196336478607617884810191902583757301606279109781032863534766846457607838041432051211158968261992230153124492441511171685297367319014610821293109532651264152683844734149471044318252404555037211418912826801581503805886363290247937041102939213895836430529539518384673470765379110379450273823891472725315186603525620809677838951")
A = 236546365290959227914433225187023916963
B_LCG = 167616762206619817706864135870591968753
LEAKS = [3531552479, 2499828603, 2190393553, 1481676222, 1690883128, 2210042718, 41709825, 3439567070]
CT = bytes.fromhex("ef10add81097716c9c856a7903d8025a6182a6d0c5219145a72e81c399fac24e7e14493269e45c59f6e560b0a43ae1f115556cee064a8288857249a9a841c889eff03b03fe949dd3838e7d176997513fd9c367cb38faa6536a1342aabc733b1059bb73979549a7ff16f2f744161df3e26b908ff79fedd422ed39f570f773308bbdf3585bed76016a0a3d1a50cc3579d19a043853f9d479d4325e35e01055a37fdbfe97db364aa91481206470e8e3a14eedce7583ca1eabf40a7af3e45d")

CAPSULE_MAGIC = b"0xV0ID//SEAL-I//"
CAPSULE_NOISE = 208
HEADER = (b"[0xV0ID // SECURE TRANSMISSION]\n"
          b"NODE   : V-7 (NULLSTAR)\n"
          b"CLASS  : OMEGA / EYES-ONLY\n"
          b"NOTICE : keystream is single-use, do not reissue seals\n"
          b"PAYLOAD: ")
FOOTER = b"\n[EOT]\n"

LENGTHS = (19, 21, 23)
MERSENNE_FACTORS = {19: (524287,), 21: (7, 127, 337), 23: (47, 178481)}
TRUNC = 96


# ---------------- Seal I: Franklin-Reiter related messages ----------------
def poly_divmod_mod(f, g, mod):
    """Polynomial division over Z/modZ. f,g high-degree-first lists."""
    f = [c % mod for c in f]
    g = [c % mod for c in g]
    while f and f[0] == 0:
        f.pop(0)
    g = [c for c in g]
    inv_lc = pow(g[0], -1, mod)
    q = [0] * (len(f) - len(g) + 1) if len(f) >= len(g) else [0]
    r = f[:]
    while len(r) >= len(g):
        factor = r[0] * inv_lc % mod
        q[len(r) - len(g)] = factor
        for i, gc in enumerate(g):
            r[i] = (r[i] - factor * gc) % mod
        while r and r[0] == 0:
            r.pop(0)
        if not r:
            break
    return q, (r or [0])


def poly_gcd_mod(f, g, mod):
    while g and any(g):
        _, r = poly_divmod_mod(f, g, mod)
        f, g = g, r
    if not f:
        return [1]
    lc = f[0]
    inv = pow(lc, -1, mod)
    return [c * inv % mod for c in f]


def seal1_franklin_reiter(n, e, c1, c2, delta):
    # f1 = x^e - c1 ; f2 = (x+delta)^e - c2 ; gcd mod n is linear: x - m1
    f1 = [1] + [0] * (e - 1) + [(-c1) % n]
    # expand (x+delta)^e
    from math import comb
    f2 = [comb(e, k) * pow(delta, e - k, n) % n for k in range(e, -1, -1)]
    f2[-1] = (f2[-1] - c2) % n
    g = poly_gcd_mod(f1, f2, n)
    assert len(g) == 2, (len(g), g[:3])
    a, b = g[0], g[1]
    m1 = (-b * pow(a, -1, n)) % n
    return m1


def seal1_extract(m1: int) -> bytes:
    capsule = m1.to_bytes(16 + CAPSULE_NOISE + 16, "big")
    assert capsule[:16] == CAPSULE_MAGIC, capsule[:16]
    noise = capsule[16:16 + CAPSULE_NOISE]
    prime_p = int.from_bytes(capsule[16 + CAPSULE_NOISE:], "big")
    return noise, prime_p


# ---------------- Seal II: truncated LCG state recovery (jvdsn lattice) ----------------
def lll_reduce(mat):
    from fpylll import IntegerMatrix, LLL
    n = len(mat)
    M = IntegerMatrix(n, n)
    for i in range(n):
        for j in range(n):
            M[i, j] = mat[i][j]
    LLL.reduction(M)
    return [[int(M[i, j]) for j in range(n)] for i in range(n)]


def solve_rational(B, b):
    """Exact solve of B x = b over Q (Fraction Gaussian elimination)."""
    n = len(B)
    aug = [[Fraction(B[i][j]) for j in range(n)] + [Fraction(b[i])] for i in range(n)]
    for col in range(n):
        piv = next((r for r in range(col, n) if aug[r][col] != 0), None)
        if piv is None:
            raise ValueError("singular")
        aug[col], aug[piv] = aug[piv], aug[col]
        pv = aug[col][col]
        for j in range(col, n + 1):
            aug[col][j] /= pv
        for r in range(n):
            if r != col and aug[r][col] != 0:
                f = aug[r][col]
                for j in range(col, n + 1):
                    aug[r][j] -= f * aug[col][j]
    return [aug[i][n] for i in range(n)]


def seal2_recover(p, a, c, leaks, k=128, s=32):
    """Recover full LCG states from truncated (top-s-bit) outputs. Returns state list + next state."""
    diff = k - s
    m = p
    y = list(leaks)
    delta = c % m
    yadj = []
    for i in range(len(y)):
        yadj.append((y[i] << diff) - delta)
        delta = (a * delta + c) % m

    n = len(y)
    mat = [[0] * n for _ in range(n)]
    mat[0][0] = m
    for i in range(1, n):
        mat[i][0] = a ** i
        mat[i][i] = -1
    B = lll_reduce(mat)

    bvec = [sum(B[i][j] * yadj[j] for j in range(n)) for i in range(n)]
    for i in range(n):
        bvec[i] = round(Fraction(bvec[i], m)) * m - bvec[i]

    x = solve_rational(B, bvec)
    x = [int(round(v)) for v in x]

    delta = c % m
    states = []
    for i in range(n):
        states.append(yadj[i] + x[i] + delta)
        delta = (a * delta + c) % m
    return states, (a * states[-1] + c) % m


# ---------------- Seal III: LFSR combiner ----------------
def gf2_mulmod(a, b, mod, n):
    r = 0
    while b:
        if b & 1:
            r ^= a
        b >>= 1
        a <<= 1
        if a >> n & 1:
            a ^= mod
    return r


def gf2_powmod(base, exp, mod, n):
    r, base = 1, base % (1 << n)
    while exp:
        if exp & 1:
            r = gf2_mulmod(r, base, mod, n)
        base = gf2_mulmod(base, base, mod, n)
        exp >>= 1
    return r


def is_primitive(taps, n):
    if not taps & 1:
        return False
    poly = taps | (1 << n)
    order = (1 << n) - 1
    if gf2_powmod(2, order, poly, n) != 1:
        return False
    return all(gf2_powmod(2, order // q, poly, n) != 1 for q in MERSENNE_FACTORS[n])


def derive_taps(seed, n, label):
    xof = hashlib.shake_256(b"VOIDLOCK/TAPS/" + label + b"/" + seed.to_bytes(16, "big")).digest(8192)
    for i in range(0, len(xof) - 4, 4):
        cand = (int.from_bytes(xof[i:i + 4], "big") & ((1 << n) - 1)) | 1
        if is_primitive(cand, n):
            return cand
    raise RuntimeError("no primitive polynomial found")


class LFSR:
    def __init__(self, taps, state, n):
        self.taps, self.state, self.n = taps, state % (1 << n), n
        if self.state == 0:
            raise ValueError("dead register")

    def clock(self):
        out = self.state & 1
        fb = bin(self.state & self.taps).count("1") & 1
        self.state = (self.state >> 1) | (fb << (self.n - 1))
        return out


def seal_three(seed, states, nbytes):
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


def find_states_in_noise(noise, seed, nbytes_need):
    """Try to locate 3 LFSR states inside the noise blob (consecutive 16-byte LE chunks)."""
    for chunk in (16, 12, 8, 4, 3):
        for base in range(0, len(noise) - 3 * chunk + 1):
            for perm in ((0, 1, 2), (0, 2, 1), (1, 0, 2), (1, 2, 0), (2, 0, 1), (2, 1, 0)):
                states = tuple(int.from_bytes(noise[base + perm[i] * chunk:base + (perm[i] + 1) * chunk], "big")
                               for i in range(3))
                try:
                    ks = seal_three(seed, states, nbytes_need)
                except ValueError:
                    continue
                if ks == bytes(a ^ b for a, b in zip(CT, HEADER))[:nbytes_need]:
                    return base, chunk, perm, states
    return None



# ---------------- Seal III recovery: correlation attack ----------------
def lfsr_masks(n, taps, T):
    """Output masks M_t: out_t = parity(state0 & M_t). Adjoint transition: M <- T^T M."""
    M = [0] * T
    m = 1
    for t in range(T):
        M[t] = m
        top = (m >> (n - 1)) & 1
        m = (m << 1) & ((1 << n) - 1)
        if top:
            m ^= taps
    return M


def wht(a):
    """In-place Walsh-Hadamard transform (no normalization). a: float64 2^n."""
    a = a.reshape(-1)
    n = a.shape[0]
    h = 1
    while h < n:
        a2 = a.reshape(-1, 2 * h)
        x = a2[:, :h].copy()
        y = a2[:, h:].copy()
        a2[:, :h] = x + y
        a2[:, h:] = x - y
        h *= 2
    return a.reshape(-1)


def recover_correlated_register(n, taps, kbits):
    """Recover LFSR initial state whose output correlates with kbits (3/4 bias)."""
    T = len(kbits)
    M = lfsr_masks(n, taps, T)
    size = 1 << n
    f = np.zeros(size, dtype=np.float64)
    for t, m in enumerate(M):
        f[m] += 1.0 if kbits[t] else -1.0
    F = wht(f)
    F[0] = 1e18  # exclude zero state (dead register); true state is argmin
    s = int(np.argmin(F))
    return s, F[s]


def gf2_solve(pivots, nvars):
    """Solve linear system over GF(2). pivots: list of (mask, rhs). Returns state or None."""
    rows = []  # (mask, rhs)
    for mask, rhs in pivots:
        rows.append([mask, rhs])
    rank = 0
    for col in range(nvars):
        piv = next((r for r in range(rank, len(rows)) if (rows[r][0] >> col) & 1), None)
        if piv is None:
            continue
        rows[rank], rows[piv] = rows[piv], rows[rank]
        for r in range(len(rows)):
            if r != rank and (rows[r][0] >> col) & 1:
                rows[r][0] ^= rows[rank][0]
                rows[r][1] ^= rows[rank][1]
        rank += 1
        if rank == nvars:
            break
    for mask, rhs in rows:
        if mask == 0 and rhs == 1:
            return None
    state = 0
    for r in range(rank):
        m, b = rows[r]
        if m:
            bit = (m & -m).bit_length() - 1
            if b:
                state |= 1 << bit
    return state


def recover_states_from_keystream(seed, kbits):
    """kbits: known keystream bits (list of 0/1). Returns (s_alpha, s_beta, s_gamma)."""
    taps = {n: derive_taps(seed, n, lbl) for n, lbl in zip(LENGTHS, (b"ALPHA", b"BETA", b"GAMMA"))}
    n1, n2, n3 = LENGTHS
    s1, c1 = recover_correlated_register(n1, taps[n1], kbits)
    s3, c3 = recover_correlated_register(n3, taps[n3], kbits)
    print("  alpha:", s1, "corr:", c1, "beta taps:", taps[n2], "gamma:", s3, "corr:", c3)

    M2 = lfsr_masks(n2, taps[n2], len(kbits))
    out1 = [bin(s1 & m).count("1") & 1 for m in lfsr_masks(n1, taps[n1], len(kbits))]
    out3 = [bin(s3 & m).count("1") & 1 for m in lfsr_masks(n3, taps[n3], len(kbits))]
    pivots = []
    for t, k in enumerate(kbits):
        if out1[t] ^ out3[t]:
            pivots.append((M2[t], k ^ out3[t]))
        elif k != out3[t]:
            return None, None, None  # inconsistent -> wrong x1/x3
    s2 = gf2_solve(pivots, n2)
    return s1, s2, s3


def keystream_bits(ks_bytes):
    bits = []
    for b in ks_bytes:
        for sh in range(7, -1, -1):
            bits.append((b >> sh) & 1)
    return bits

def main():
    print("== Seal I ==")
    m1 = seal1_franklin_reiter(N, E, C1, C2, DELTA)
    noise, prime_p = seal1_extract(m1)
    print("PRIME_P =", prime_p)
    print("noise len:", len(noise), "hex:", noise.hex())
    assert prime_p == 288310518992978189772694459632328173577

    print("== Seal II ==")
    a, c = A % prime_p, B_LCG % prime_p
    states, seed = seal2_recover(prime_p, a, c, LEAKS)
    print("states:", states)
    print("seed (x_8):", seed)
    # validate
    x = states[0]
    for i, lk in enumerate(LEAKS):
        assert x >> TRUNC == lk, (i, x >> TRUNC, lk)
        x = (a * x + c) % prime_p
    assert x == seed
    print("seal II validated")

    print("== Seal III ==")
    ks_known = bytes(a ^ b for a, b in zip(CT, HEADER))
    kbits = keystream_bits(ks_known)
    s1, s2, s3 = recover_states_from_keystream(seed, kbits)
    assert s1 is not None and s2 is not None and s3 is not None, "recovery failed"
    print("LFSR states:", (s1, s2, s3))
    ks = seal_three(seed, (s1, s2, s3), len(CT))
    pt = bytes(a ^ b for a, b in zip(CT, ks))
    print("plaintext:", pt.decode("latin1"))
    assert pt.startswith(HEADER) and pt.endswith(FOOTER)
    flag = pt[len(HEADER):-len(FOOTER)].decode()
    print("FLAG:", flag)


if __name__ == "__main__":
    main()
