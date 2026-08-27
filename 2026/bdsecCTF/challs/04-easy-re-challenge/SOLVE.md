**Flag:** `BDSEC{e4SY_r3v3rS3_eNg1N33r1nG_cH4LL4ng3}`

**TL;DR** ELF has 4 length-branches (24/26/29/41); only len==41 → "Excellent work" (real). Invert its per-byte transform.

**Find** `main` reads input, `strcspn` for length, then branches on len. Branches 24/26/29 print
"Congratulations… Keep exploring" = decoys. len==41 (0x12fb) builds a buffer from key_part_a/b and
compares to `expected.3` (41 bytes @0x2420), success = "Excellent work, reverse engineer!".

**Solve** Forward (per i, 0..40):
`out[(13*i)%41] = (rol8(key_a[i%8]^key_b[i%8]^inp[i], (i%7)+1) + ((11*i)^0x23)) & 0xff`
Fully invertible ((13,41) coprime → position is a permutation). Data pulled from binary:
- key_a @0x2458 = 19 a4 c7 52 6e 01 9b f0
- key_b @0x2450 = 5b 75 b4 7b cb 5d 73 e6
- target = expected.3 @0x2420 (41 bytes)
Inverse in solver.py → flag; verified by forward re-encode == target.
