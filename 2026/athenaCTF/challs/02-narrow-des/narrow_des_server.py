#!/usr/bin/env python3
"""Pure-Python Narrow DES server fallback for environments without gcc.

Usage: echo 0123456789abc | python out/narrow_des_server.py
"""
import sys

P = [8, 18, 3, 2, 15, 24, 10, 14, 20, 7, 5, 13, 1, 6, 21, 9,
     4, 11, 23, 22, 12, 19, 16, 17]

S = [
    [5,3,0,2,7,1,4,6,1,6,4,7,5,0,3,2],
    [4,1,0,5,3,7,6,2,1,4,0,5,2,6,3,7],
    [3,4,2,0,7,6,1,5,3,7,6,0,4,2,1,5],
    [5,6,4,2,7,0,3,1,6,5,7,2,1,3,4,0],
    [5,6,7,3,1,0,4,2,3,6,2,1,7,4,0,5],
    [0,3,1,4,6,5,2,7,0,3,5,4,7,6,1,2],
    [6,0,4,2,3,5,1,7,0,6,7,3,2,1,4,5],
    [0,5,6,2,3,7,4,1,2,4,0,7,3,1,5,6]
]

def des_block(msg, key, rounds=32):
    # msg: 48-bit integer, key: 64-bit integer
    LB24_MASK = (1<<24)-1
    LB32_MASK = (1<<32)-1
    L = (msg >> 24) & LB24_MASK
    R = msg & LB24_MASK
    sub_key = [ (key >> 32) & LB32_MASK, key & LB32_MASK ]
    for i in range(rounds):
        expanded = 0
        for j in range(7):
            expanded |= ((R >> (20 - 3*j)) & 0xf) << (28 - 4*j)
        expanded |= (R & 7) << 1 | (R >> 23)
        expanded = expanded ^ sub_key[i // 16]
        s_output = 0
        for j in range(8):
            temp = (expanded >> (4*j)) & 0xf
            s_output <<= 3
            s_output |= S[j][temp]
        p_output = 0
        for j in range(24):
            p_output <<= 1
            p_output |= (s_output >> (24 - P[j])) & 1
        temp = R
        R = L ^ p_output
        L = temp
    return (L << 24) | R

def main():
    key = 0
    try:
        # try to read embedded key from sibling secret file
        import os
        here = os.path.dirname(__file__)
        sec = os.path.join(here, '..', 'secret.txt')
        with open(sec, 'r') as f:
            s = f.read().strip()
            import re
            m = re.match(r"athena\{([0-9a-fA-F]+)\}", s)
            if m:
                hexk = m.group(1).rjust(16, '0')[:16]
                key = int(hexk, 16)
    except Exception:
        key = 0

    # interactive: process one line at a time (each line is up to 64*12 hex)
    while True:
        line = sys.stdin.readline()
        if not line:
            break
        data = line.strip()
        if not data:
            sys.stdout.write("\n")
            sys.stdout.flush()
            continue
        out_blocks = []
        for i in range(0, len(data)//12):
            blk = data[12*i:12*(i+1)]
            try:
                m = int(blk, 16)
            except Exception:
                m = 0
            res = des_block(m, key)
            out_blocks.append(f"{res:012x}")
        sys.stdout.write(''.join(out_blocks) + "\n")
        sys.stdout.flush()

if __name__ == '__main__':
    main()
