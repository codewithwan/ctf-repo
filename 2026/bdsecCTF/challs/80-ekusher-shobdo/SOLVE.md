**Flag:** `BDSEC{sh0bd0_k0kh0n0_b0nd1_th4k3_n4}`

**TL;DR** C++ record CRUD (PIE/RELRO/NX/canary). "Inspect metadata" leaks the object's heap addr + vtable ptr (PIE). "Reclassify" lets you set a record to hidden type 5 "IMPORT"; "Edit" on a type-5 record does a raw hex-byte write starting at obj+0 → overwrite the vtable pointer. Display/Publish `call [obj][0/8]` with no type check → hijack to fn @0x1dd0 which open()/read()/print()s flag.txt.

**Find** win fn @0x1dd0 (no refs) reads flag.txt. Records @0x5060 (16×[obj_ptr,type_id]). Reclassify writes new type_id (1..5) into the slot; Edit switches on type_id, and type 5 calls the "Raw bytes (hex)" parser which does `mov byte[obj+rcx], b` from rcx=0 → controls the vtable pointer. Display=`call [[obj]+0]`, Publish=`call [[obj]+8]`.

**Exploit** (pwntools): create Poem → Inspect → `pie = dispatch - 0x4c08`, `win = pie + 0x1dd0`, `heap = storage` → Reclassify to 5 → Edit hex = `p64(storage+8) + p64(win)*2` (obj+0 points at obj+8; obj+8/obj+16 = win) → Publish → `call [storage+8 + 8] = win` → flag. See exploit.py (`python3 exploit.py 45.56.67.129 54821`).

**Reusable takeaway** A "reclassify/import" that flips an object's type tag to a state whose edit path is a raw-byte writer = a vtable-overwrite primitive. Pair it with any leak of the object's own vtable ptr (PIE) + heap addr, point the (now heap-controlled) vtable at a slot holding your target, and any un-type-checked virtual call (`call [[obj]+N]`) jumps there.
