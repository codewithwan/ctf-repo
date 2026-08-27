target = bytes.fromhex("544738b3c4a7c8bb2c558863fc465813" "2c8da8838c3660c17c6760")
assert len(target) == 27

def ror(v, n): 
    v &= 0xff
    return ((v >> n) | (v << (8-n))) & 0xff
def rol(v, n):
    v &= 0xff
    return ((v << n) | (v >> (8-n))) & 0xff

# invert forward: out[i] = rol(in[i],3) ^ (key&0xff); key=0x5f; key=key*0x6b+0x2f (32-bit)
key = 0x5f
flag = bytearray()
for i in range(27):
    c = target[i] ^ (key & 0xff)      # undo xor
    p = ror(c, 3)                      # undo rol by 3
    flag.append(p)
    key = (key * 0x6b + 0x2f) & 0xffffffff
flag = bytes(flag)
print("recovered:", flag)

# forward re-check
key = 0x5f
out = bytearray()
for i in range(27):
    c = rol(flag[i], 3) ^ (key & 0xff)
    out.append(c & 0xff)
    key = (key * 0x6b + 0x2f) & 0xffffffff
print("forward match:", bytes(out) == target)
