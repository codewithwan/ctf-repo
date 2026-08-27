def xor_bytes(data, key, start_phase=0):
    res = []
    for i in range(len(data)):
        k = key[(i + start_phase) % len(key)]
        res.append(chr(data[i] ^ k))
    return "".join(res)

key = b"DR1FT"

# Hex data from PAGE 0x8a0000, 0x8a1000, and 0x8a2000 (first lines)
p1 = bytes.fromhex("25 26 59 23 3a 25 29 43 27 39 1b 22")
p2 = bytes.fromhex("50 21 31 37 0d 59 2f 30 21 0d 57 34")
p3 = bytes.fromhex("35 23 3f 54 28 20 37 2f")

# Decoding the three segments
part1 = xor_bytes(p1, key, 0)
part2 = xor_bytes(p2, key, len(p1))
part3 = xor_bytes(p3, key, len(p1) + len(p2))

print("Part 1:", repr(part1))
print("Part 2:", repr(part2))
print("Part 3:", repr(part3))

full_flag = part1 + part2 + part3
print("\n[+] Flag:", full_flag)
