#!/usr/bin/env python3

KEY = [10, 21, 99, 4, 534, 24, 63, 57, 102, 38, 0, 123, 53, 674, 12, 57]
CT = [221, 75, 97, 125, 30, 124, 51, 122, 15, 186, 39, 46, 74, 175, 120, 83, 219, 165]


def encrypt_pair(left, right, wvtf):
    for k in KEY:
        mask = ((right + (k + 1) * wvtf) * 17) % 135
        left, right = right, left ^ mask
    return left, right, wvtf + left + right


def main():
    wvtf = 1
    plain = []
    for left_ct, right_ct in zip(CT[0::2], CT[1::2]):
        hits = []
        for left in range(256):
            for right in range(256):
                enc_left, enc_right, next_wvtf = encrypt_pair(left, right, wvtf)
                if (enc_left, enc_right) == (left_ct, right_ct):
                    hits.append((left, right, next_wvtf))
        if len(hits) != 1:
            raise RuntimeError(f"ambiguous pair at wvtf={wvtf}: {hits!r}")
        left, right, wvtf = hits[0]
        plain += [left, right]

    msg = bytes(plain).decode()
    print(msg)
    print(f"bushbash{{{msg}}}")


if __name__ == "__main__":
    main()
