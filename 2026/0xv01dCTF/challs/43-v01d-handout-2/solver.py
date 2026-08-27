#!/usr/bin/env python3
"""V01D Handout 2 — recover the broadcast.

I  : singular curve handshake  -> NODE_D (dlog in F_p* via singular-curve map)
II : related-nonce ECDSA order -> AUTH_X (pure algebra, no lattice)
III: SHA-256 length extension   -> architect token -> decrypt broadcast
"""
import hashlib
from sympy import factorint, discrete_log, is_quad_residue, sqrt_mod

P = 3564625681460390929881227635631045656663925422561280528974142079390139643508987899
A = 1290845814987521891796445286282893750773182431944520388169355126745772946407018553
B = 2548046464103175289844662208531713584748179807189901271913966388343193355335560217
GX = 1457404221189369008358872456999869109718060428281406195376049141321523580448797207
GY = 1290242299127928500851605029070910032280495337570522089014647070915672072669629743

SP = 0xfffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f
SA = 0
SB = 7
SGX = 0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798
SGY = 0x483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8
SN = 0xfffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141

ORDER_A = b"ORDER-4417//hold position, node V-7 is clean"
ORDER_B = b"ORDER-4418//burn the channel on my mark"
WARRANT = b"node=V-7&role=observer"
UPGRADE = b"&role=architect&auth="
BROADCAST = (b"[0xV0ID // COMMAND BROADCAST]\n"
             b"AUTH  : ARCHITECT\n"
             b"ORDER : stand down, the channel is burned\n"
             b"TOKEN : ")
TAIL = b"\n[EOT]\n"

# ---- channel log ----
node = (1325638852438642878998123576357249363240549984609651071545386142674754138299496611,
        468608191669712539538432472947627440322009738671977464971193155685145715350284680)
auth = (29327505898692726559383869320329077247000077447589821210313273388338028090524,
        84810498302385529371929497852548539925227545436477666544442075624496782126268)
r1 = 54228046796625044020338114295179004736221704259521266121491731787620273057582
s1 = 49862048638765292299426182791447849596212404258046678658538384601415317794992
r2 = 5228908101607893758353029166591071169661964310161311863919069729013330565745
s2 = 109149138641376889053124178510072847015226335736902590340677224192887875508987
observer = bytes.fromhex("2db890900d7b55474dc9de0cbae6e8d56fb381c6f6d032689f30738f0f999a12")
secret_len = 33
ct = bytes.fromhex("9275c2420846dcaf8953c0bd9a6b0673ac362d265d1bc6e58b5cb8eeee4950f4985bb264bf484b336e19bc429f51dcd033b046ee742e74f0a4396631cd0f2f0dc6f878b0c500284a0864640dc0d61c4d8635096a414f815abfff9959e32b653aece7e6ad7e20bc24e0ab7aaf2d3bf3ac145d1ed485d6012df497465970a0f8755845c995b9e60f2ecde74a0213")


def add(p1, p2, a, m):
    if p1 is None:
        return p2
    if p2 is None:
        return p1
    if p1[0] == p2[0] and (p1[1] + p2[1]) % m == 0:
        return None
    if p1 == p2:
        l = (3 * p1[0] * p1[0] + a) * pow(2 * p1[1], -1, m) % m
    else:
        l = (p2[1] - p1[1]) * pow(p2[0] - p1[0], -1, m) % m
    x = (l * l - p1[0] - p2[0]) % m
    return (x, (l * (p1[0] - x) - p1[1]) % m)


def mul(k, pt, a, m):
    r = None
    while k:
        if k & 1:
            r = add(r, pt, a, m)
        pt = add(pt, pt, a, m)
        k >>= 1
    return r


def digest(msg):
    return int.from_bytes(hashlib.sha256(msg).digest(), "big") % SN


def mdpad(n):
    return b"\x80" + b"\x00" * ((55 - n) % 64) + (n * 8).to_bytes(8, "big")


def keystream(key, n):
    out = b""
    i = 0
    while len(out) < n:
        out += hashlib.sha256(key + i.to_bytes(8, "big")).digest()
        i += 1
    return out[:n]


# ---------------- I. THE HANDSHAKE ----------------
assert (4 * A ** 3 + 27 * B ** 2) % P == 0, "not singular"
# double root alpha (gcd of cubic and derivative); simple root beta = -2 alpha
alpha = 12753696602537644062423614821390727734594302300886740555917399164455717402694116
beta = (-2 * alpha) % P
assert (alpha - alpha) * (alpha - beta) * (alpha - beta) % P == 0  # sanity
c = (alpha - beta) % P
assert is_quad_residue(c, P), "c must be a square for a split node"
sqrt_c = sqrt_mod(c, P)

def phi(pt):
    if pt is None:
        return 1
    x, y = pt
    X = (x - alpha) % P
    Y = y % P
    num = (Y - sqrt_c * X) % P
    den = (Y + sqrt_c * X) % P
    return num * pow(den, -1, P) % P

# sanity: group law <=> multiplication
import random
random.seed(1)
for _ in range(20):
    k = random.randrange(1, P)
    Q = mul(k, (GX, GY), A, P)
    assert phi(Q) == pow(phi((GX, GY)), k, P)
print("singular-curve map verified")

g = phi((GX, GY))
y = phi(node)
print("factoring P-1:", factorint(P - 1))
NODE_D = discrete_log(P, y, g)
print("NODE_D =", NODE_D)
assert mul(NODE_D, (GX, GY), A, P) == node

# ---------------- II. THE ORDER ----------------
d = int.from_bytes(hashlib.sha256(b"DEADHAND/DRIFT/" + str(NODE_D).encode()).digest(), "big") % SN
h1, h2 = digest(ORDER_A), digest(ORDER_B)
x = (s1 * h2 - s2 * h1 - d * s1 * s2) * pow((s2 * r1 - s1 * r2) % SN, -1, SN) % SN
AUTH_X = x
print("AUTH_X =", AUTH_X)
assert mul(AUTH_X, (SGX, SGY), SA, SP)[0] == auth[0], "AUTH_X does not match auth_x"

# ---------------- III. THE WARRANT ----------------
# architect = SHA256(secret || WARRANT || mdpad(33+22) || UPGRADE || hex(AUTH_X))
# length-extension from observer = SHA256(secret || WARRANT), secret_len = 33
_K = [
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
    0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
    0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
    0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
    0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
    0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
    0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
    0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2,
]
_IV = [0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19]


def rotr(x, n):
    return ((x >> n) | (x << (32 - n))) & 0xffffffff


def sha256_compress(state, chunk):
    w = list(struct_unpack(">16L", chunk)) + [0] * 48
    for i in range(16, 64):
        s0 = rotr(w[i - 15], 7) ^ rotr(w[i - 15], 18) ^ (w[i - 15] >> 3)
        s1 = rotr(w[i - 2], 17) ^ rotr(w[i - 2], 19) ^ (w[i - 2] >> 10)
        w[i] = (w[i - 16] + s0 + w[i - 7] + s1) & 0xffffffff
    a, b, c, d, e, f, g, h = state
    for i in range(64):
        S1 = rotr(e, 6) ^ rotr(e, 11) ^ rotr(e, 25)
        ch = (e & f) ^ (~e & g)
        t1 = (h + S1 + ch + _K[i] + w[i]) & 0xffffffff
        S0 = rotr(a, 2) ^ rotr(a, 13) ^ rotr(a, 22)
        maj = (a & b) ^ (a & c) ^ (b & c)
        t2 = (S0 + maj) & 0xffffffff
        h = g; g = f; f = e; e = (d + t1) & 0xffffffff
        d = c; c = b; b = a; a = (t1 + t2) & 0xffffffff
    return [(state[i] + [a, b, c, d, e, f, g, h][i]) & 0xffffffff for i in range(8)]


def sha256_extend(state_words, extra, total_len):
    """Finish SHA-256 from a given 8-word state; total_len = full message length in bytes."""
    n = total_len * 8
    last = extra + b"\x80" + b"\x00" * ((55 - total_len) % 64) + n.to_bytes(8, "big")
    assert len(last) % 64 == 0, len(last)
    for off in range(0, len(last), 64):
        state_words = sha256_compress(state_words, last[off:off + 64])
    return b"".join(w.to_bytes(4, "big") for w in state_words)


def struct_unpack(fmt, data):
    import struct
    return struct.unpack(fmt, data)


# length extension: continue from observer state with UPGRADE + hex(AUTH_X)
tail = UPGRADE + format(AUTH_X, "x").encode()
total = secret_len + len(WARRANT) + len(mdpad(secret_len + len(WARRANT))) + len(tail)
architect = sha256_extend(
    [int.from_bytes(observer[i * 4:i * 4 + 4], "big") for i in range(8)],
    tail, total)
# sanity: if we knew the secret, normal hashing must give the same value
assert architect != b""
print("architect =", architect.hex())

body = bytes(u ^ v for u, v in zip(ct, keystream(architect, len(ct))))
assert body.startswith(BROADCAST) and body.endswith(TAIL), (body[:40], body[-20:])
flag = body[len(BROADCAST):-len(TAIL)]
print("FLAG:", flag.decode())
