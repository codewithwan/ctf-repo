# Logic Puzzle solver — static (no need to run the ELF)
# main: strtol(argv[1]) -> n; requires n*(n-1)==0x1b4178 -> n=1337
# then LCG(seed=n) keystream XOR 25 bytes @ .rodata 0x2010, verified by FNV-ish check
enc = bytes.fromhex("686144dd7d01d001e29cad166cefe0f9cce4a967dfc17a235c")
MASK=(1<<64)-1
state=1337
out=bytes(((state:=(state*0x5851f42d4c957f2d+0x14057b7ef767814f)&MASK)>>33&0xff)^b for b in enc)
print("input :", 1337)
print("flag  :", out.decode())
