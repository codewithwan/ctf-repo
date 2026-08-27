**Flag:** `BDSEC{ph4nt0m_h4ndl35_n3v3r_d13}`

**TL;DR** Non-PIE heap CRUD (devices + sessions, both calloc 0x100). "Duplicate handle" copies a device ptr into a new handle WITHOUT a refcount; "Release" frees the chunk but only clears one handle → the duplicate is a dangling UAF handle. Overlap a fresh **session** onto that freed chunk, then use the dangling device Read/Write to leak+forge the session's integrity tokens and flip its privilege magic → "Request privileged data" reads flag.txt.

**Find** Session @ [magic "PHSESSIO", uid(+8), magic2(+0x10)=1, role(+0x18), tok1(+0x20), tok2(+0x28)]. Handler-8 requires magic2==0x1337133713371337 (Create sets it to 1) AND two tokens. tok1's formula matches Create-session, but **tok2 differs only by a constant**: handler wants `...^rol(uid+0x5478547854785478,0x1d)`, Create stores `...^rol(0x414141414141452a+idx,0x1d)`.

**Exploit** 1) calloc bypasses tcache → alloc 8 devices, dup handle 7, free handles 0-6 to FILL tcache[0x110], free handle 7 → it lands in the **unsorted bin**. 2) Create session → its calloc pulls from unsorted → **session overlaps the dangling handle 8**. 3) Read via handle 8 → leak stored tok2. 4) `forged = tok2 ^ rol(0x414141414141452a+idx,0x1d) ^ rol(uid+0x5478547854785478,0x1d)` (no key needed!). 5) Write via handle 8: `[+0x10]=0x1337...` and `[+0x28]=forged`. 6) Request privileged → flag. See exploit.py.

**Reusable takeaway** `calloc()` does NOT use tcache (goes straight to _int_malloc) — to make a calloc alloc reuse a freed chunk you must push it out of tcache (fill the 7 slots) into fastbin/unsorted. And a keyed integrity token can be forged without the key when the "set" and "check" sites differ by a *known* term — just XOR the delta of constants onto the leaked value.
