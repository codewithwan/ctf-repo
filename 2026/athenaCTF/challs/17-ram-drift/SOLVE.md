# RAM Drift - Solve Writeup

## 1. Menganalisis Process Map
Berdasarkan `process_map.txt`:
```
pid  name               base      size    xor tag
901  photo_recover      0x8a0000  0x3c00  tag=DR1FT
```
Dapat kita lihat bahwa halaman memori yang di-dump di `ram_dump.txt` (yaitu `0x8a0000`, `0x8a1000`, `0x8a2000`) berada dalam rentang memory space milik proses `photo_recover` (base `0x8a0000`, size `0x3c00`).
XOR tag untuk proses ini adalah `DR1FT`.

## 2. Struktur Memori & Page-Level Transform
Di `ram_dump.txt` terdapat data hex-dump di offset `00000000` dari tiga halaman memori berurutan:
- **PAGE 0x8a0000**: `25 26 59 23 3a 25 29 43 27 39 1b 22` (12 byte)
- **PAGE 0x8a1000**: `50 21 31 37 0d 59 2f 30 21 0d 57 34` (12 byte)
- **PAGE 0x8a2000**: `35 23 3f 54 28 20 37 2f` (8 byte)

Mengingat buffer ini kontinu tetapi terbagi di halaman-halaman yang berbeda, XOR key `DR1FT` yang berulang (5 byte) akan berlanjut secara kontinu di seluruh buffer (atau dihitung berdasarkan phase/indeks kumulatif buffer):
- **Page 1**: Mulai dari phase 0 (indeks XOR key 0)
- **Page 2**: Mulai dari phase `12` (karena Page 1 memiliki 12 byte), yang setara dengan index key `12 % 5 = 2`.
- **Page 3**: Mulai dari phase `12 + 12 = 24`, yang setara dengan index key `24 % 5 = 4`.

## 3. XOR Dekripsi
Dengan melakukan XOR dengan key `DR1FT` menggunakan script solver:
- **Page 1**: `25 26 59 23 3a 25 29 43 27 39 1b 22` XOR `DR1FTDR1FTDR` $\rightarrow$ `athena{ram_p`
- **Page 2**: `50 21 31 37 0d 59 2f 30 21 0d 57 34` XOR `1FTDR1FTDR1F` $\rightarrow$ `ages_hide_fr`
- **Page 3**: `35 23 3f 54 28 20 37 2f` XOR `TDR1FTDR` $\rightarrow$ `agments}`

Menggabungkan ketiganya menghasilkan flag lengkap.

## Flag
`athena{ram_pages_hide_fragments}`
