# Heap Smash v1 — SOLVED

**Flag:** `athena{iJ5L4IZIEXGSprnA}`

- **Category:** PWN (easy) · `nc 13.206.57.188 10044`
- **Vuln:** Uninitialized-heap / UAF leak (glibc 2.32+, tcache + safe-linking).

## Protokol
- `A <idx> <size>` alloc note (size 1–178)
- `W <idx> <off> <len>` + kirim `len` byte raw → write
- `R <idx>` read `size` byte note
- `D <idx>` free (R setelah free = "No note", pointer di-null)

## Bug
Flag di-`malloc` (chunk **0x60**), diisi, di-`free` pas startup → masuk **tcache[0x60]**.
`malloc` gak nge-nol chunk yang di-reclaim, jadi alloc note size 0x60 balikin chunk flag
dengan isi masih utuh. 16 byte pertama ketiban metadata tcache (next=`heap>>12` mangled +
key), tapi **flag utuh mulai offset 16**.

## Exploit
```
A 0 88          # 88+8 -> chunk 0x60 (== ukuran chunk flag)
R 0             # baca -> "....<meta 16B>....athena{iJ5L4IZIEXGSprnA}"
```
Nemu size-nya dgn sweep semua chunk-size class (0x20..0xC0, max note=178) di koneksi fresh
tiap size (biar tcache pristine): cuma size **88 (chunk 0x60)** yang bocor flag.

## Catatan
Sweep awal (size ≤64) gagal karena flag chunk = 0x60 (butuh request 73–88), di luar range.
