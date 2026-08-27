# Afterimage Protocol · rev

**Status:** solved
**Flag:** `0xV01D{N3bula7R4v3n9X2Q}`

**Technique tags:** rev, x86-64, unicorn-emulation, custom-vm, fnv-1a, splitmix64, tape-interpreter, inversion
**Signals:** stripped static ELF; parser accepts only 16 alphanumeric body chars; 320-step folded tape VM (index (41+73k)%320) mutates the body; final check compares the post-VM buffer against a fixed tape at 0x402aa0 using the FNV-1a + splitmix64 state.
**Verification:** Unicorn (`UC_HOOK_INSN` on `syscall`) emulated the full binary; buffer after each of the 320 VM steps matched the Python forward model on multiple inputs, and a full run with `0xV01D{N3bula7R4v3n9X2Q}\n` exits 0 and prints "reflection accepted".
**Reusable takeaway:** when a validator runs a VM over the input and checks a mutated buffer, compute the post-VM target then invert the ops; port `x ^= rsi; x += K` carefully (Python precedence), and verify every constant from raw bytes (op0's xor constant 0x9e3779b185ebca87 differs from the golden-ratio 0x9e3779b97f4a7c15).
**Failed approaches:** initial static solver treated the final-check target as the pre-VM input and ignored the VM mutation (non-alnum output); opcode dispatch was initially assumed in jump-table order; op5's rotate-by-0-to-1 adjustment and op0's altered xor constant were missed.
**TL;DR:** Recover the 16-char body accepted by the folded-tape VM by deriving the input-independent op stream, computing the post-VM target from the FNV/splitmix check, and inverting the 320 ops in reverse.
