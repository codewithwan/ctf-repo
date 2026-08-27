# Global Blue Police Salute — SOLVED

**Flag:** `athena{zdomen}`

- **Category:** OSINT
- **Challenge image:** `Policia.png` — foto malam mobil **POLICIJA** (polisi Slovenia) + bendera Slovenia/EU, di depan pos polisi.

## Solve
1. Reverse image search `Policia.png` → nemu foto **original** (stock/portfolio): `interpol_orig.jpg`
   (SONY ILCE-6700, Adobe Lightroom, www.policija.si).
2. Baca EXIF foto original:
   ```
   exiftool interpol_orig.jpg | grep -Ei 'artist|creator|copyright'
   Artist / Creator (XMP) : zdomen
   Copyright / CopyrightNotice : fotodins
   ```
3. Flag = nama creator → **`athena{zdomen}`** (field Creator/Artist). ✅ confirmed.

## Catatan
Placeholder awal `athena{creator-name}` = template "isi nama creator". Jawaban = `zdomen`.
