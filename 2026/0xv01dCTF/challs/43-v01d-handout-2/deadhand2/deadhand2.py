#!/usr/bin/env python3
import hashlib

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


def handshake(scalar):
    return mul(scalar, (GX, GY), A, P)


def drift(scalar):
    return int.from_bytes(
        hashlib.sha256(b"DEADHAND/DRIFT/" + str(scalar).encode()).digest(),
        "big") % SN


def digest(msg):
    return int.from_bytes(hashlib.sha256(msg).digest(), "big") % SN


def sign(msg, x, k):
    r = mul(k, (SGX, SGY), SA, SP)[0] % SN
    s = pow(k, -1, SN) * (digest(msg) + x * r) % SN
    return r, s


def mdpad(n):
    return b"\x80" + b"\x00" * ((55 - n) % 64) + (n * 8).to_bytes(8, "big")


def tag(secret, body):
    return hashlib.sha256(secret + body).digest()


def warrant(secret, x):
    body = WARRANT + mdpad(len(secret) + len(WARRANT)) + UPGRADE + format(x, "x").encode()
    return tag(secret, body)


def keystream(key, n):
    out = b""
    i = 0
    while len(out) < n:
        out += hashlib.sha256(key + i.to_bytes(8, "big")).digest()
        i += 1
    return out[:n]


BROADCAST = (b"[0xV0ID // COMMAND BROADCAST]\n"
             b"AUTH  : ARCHITECT\n"
             b"ORDER : stand down, the channel is burned\n"
             b"TOKEN : ")

TAIL = b"\n[EOT]\n"


def main():
    from _channel import NODE_D, AUTH_X, NONCE_K, WARRANT_SECRET, FLAG

    node = handshake(NODE_D)
    auth = mul(AUTH_X, (SGX, SGY), SA, SP)

    k1 = NONCE_K
    k2 = (k1 + drift(NODE_D)) % SN
    r1, s1 = sign(ORDER_A, AUTH_X, k1)
    r2, s2 = sign(ORDER_B, AUTH_X, k2)

    observer = tag(WARRANT_SECRET, WARRANT)
    architect = warrant(WARRANT_SECRET, AUTH_X)

    body = BROADCAST + FLAG + TAIL
    ct = bytes(u ^ v for u, v in zip(body, keystream(architect, len(body))))

    print("[HANDSHAKE]")
    print("node_x = %d" % node[0])
    print("node_y = %d" % node[1])
    print()
    print("[ORDER]")
    print("auth_x = %d" % auth[0])
    print("auth_y = %d" % auth[1])
    print("r1 = %d" % r1)
    print("s1 = %d" % s1)
    print("r2 = %d" % r2)
    print("s2 = %d" % s2)
    print()
    print("[WARRANT]")
    print("observer   = %s" % observer.hex())
    print("secret_len = %d" % len(WARRANT_SECRET))
    print()
    print("[BROADCAST]")
    print("ct = %s" % ct.hex())


if __name__ == "__main__":
    main()
