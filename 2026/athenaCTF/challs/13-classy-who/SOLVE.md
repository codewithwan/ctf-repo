# Classy who? — SOLVED

**Flag:** `athena{fWLocuPa9hJR2n9y}`

- **Category:** PWN (hard, 400) · `nc 13.206.57.188 <port>` (instance)
- **Binary:** glibc note-service, PIE + full ASLR. Source `ctf.c` disediakan.
- **Exploit fully offset-independent** (scanning), jadi tahan beda libc/versi.

## Protokol (dari ctf.c)
- `C idx size` create · `W idx off len` + `len` byte raw = write · `R idx` read · `D idx` del · `E` exit
- `struct note { char *data; size_t size; }`, `notes[16]`, flag di `local_flag[256]` di **stack main**.

## Bug
1. `write_note`: `memcpy(notes[idx]->data + off, buf, len)` — **`off` gak dicek** → OOB write.
2. `delete_note`: pointer dangling **gak di-null** → UAF.

## Layout kunci
Alloc berurutan bikin: `[data(i)][struct note(i+1)][data(i+1)]...`.
Dari `note[i].data`, offset **+0x20 = note[i+1].struct.data**, **+0x28 = .size**.
→ overflow `note[0].data` nimpa `note[1] = {data, size}` → **arbitrary read** lewat `R 1`.

## Chain
1. **Heap leak:** over-read (`W 0 0x28` set note1.size besar, `R 1`) → note2.data → heap base.
2. **Arb read:** `W 0 0x20 (p64(addr)+p64(size))` ; `R 1` → baca `size` byte dari `addr`.
3. **Libc leak:** `C 10 0x500; C 11 0x18; D 10` → chunk gede ke **unsorted bin** (fd/bk=main_arena).
   Scan heap → pointer `0x7f...` = main_arena.
4. **Stack leak:** scan data-region libc deket main_arena → nilai range stack (`0x7ffc..`) = **environ**.
5. **Flag:** scan stack ke bawah dari environ → `athena{...}` di `local_flag`.

## Run
```
python3 solve.py    # (pwn.py = helper socket C/W/R/D)
```
Semua leak offset-independent (scan) → gak perlu tau versi libc.
