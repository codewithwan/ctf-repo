def ror8(val, count):
    return (val >> count) | ((val << (8 - count)) & 0xff)

# 72-byte obfuscated payload from the binary
payload = bytes.fromhex(
    "d08ec2ce8160d6c27f4938acc0458b3acc598719386622a7db415f331e3268d6"
    "120791b1c652ff51304e7add39e80672473990de423f11eabf6a7fa120fe52a7"
    "19b1d6224f91a045"
)

key = b"KEY42"

decrypted = bytearray()
for i in range(len(payload)):
    # Run the de-obfuscation logic from the binary:
    # 1. XOR with key byte
    val = payload[i] ^ key[i % len(key)]
    # 2. Rotate Right by 3 bits
    val = ror8(val, 3)
    decrypted.append(val)

print("Decrypted payload:")
print(decrypted.decode('utf-8'))
