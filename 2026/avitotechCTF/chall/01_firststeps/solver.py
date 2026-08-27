#!/usr/bin/env python3
# firststeps — the flag is computed client-side in firststeps.js; re-implement levelReward().
# xorshift PRNG seeded from the fixed board, XOR'd against embedded LEVEL_REWARD_DATA.
M = 0xFFFFFFFF
FIXED_ROWS, FIXED_COLS = 10, 15
LEVEL_ORDER = ["easy", "medium", "hard"]
FIXED_HOLE_COORDS = [[2,1],[7,1],[11,1],[4,2],[9,3],[13,3],[1,4],[6,5],[11,5],[3,7],[8,8],[12,8]]
LEVEL_REWARD_LENGTHS = [10, 9, 9]
LEVEL_REWARD_DATA = [99,179,125,189,59,220,227,52,178,148,156,34,201,91,248,251,
                     14,73,54,212,178,230,102,64,45,182,145,14,3,160]

imul = lambda a, b: ((a & M) * (b & M)) & M            # low-32 bits, like JS Math.imul
cell = lambda c, r, cols: r * cols + c

def level_reward(level):
    i = LEVEL_ORDER.index(level)
    s = (0x6d2b79f5 ^ imul(i + 1, 0x9e3779b1) ^ ((FIXED_COLS << 24) & M) ^ ((FIXED_ROWS << 16) & M)) & M
    for h, (x, y) in enumerate(FIXED_HOLE_COORDS):
        s = (s ^ imul(cell(x, y, FIXED_COLS) + h + 1, 0x045d9f3b)) & M
        s = ((s << 11) | (s >> 21)) & M
    lane = (i * 2 + 1) % len(LEVEL_ORDER)
    out = ""
    for k in range(LEVEL_REWARD_LENGTHS[i]):
        s = (s ^ ((s << 13) & M)) & M
        s = (s ^ (s >> 17)) & M
        s = (s ^ ((s << 5) & M)) & M
        out += chr(LEVEL_REWARD_DATA[k * len(LEVEL_ORDER) + lane] ^ (s & 0xFF))
    return out

print("avito{" + "".join(level_reward(l) for l in LEVEL_ORDER) + "}")
