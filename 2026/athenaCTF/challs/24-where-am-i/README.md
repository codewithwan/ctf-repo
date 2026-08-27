# Where am i

- **Category:** OSINT
- **Points:** 175
- **Solves:** 0
- **URL:** https://ctf-2026.ctf-platform.xyz/challenges/haq6mjbyo4fq8rt1b8btyd07

## Description
You are an ancient archaeologist studying a photograph of an artifact. Determine where it was discovered—the coordinates of the find site. Download the image and submit the location as `athena{latitude,longitude}` (decimal degrees, three decimal places, as in `athena{174.606,141.526}`).

## Files (download manual)
- `Whereami.jpeg` — 49 KB → taruh di folder ini

## Instance
Not required

## Submit format
`athena{latitude,longitude}` — desimal, 3 angka di belakang koma (contoh `athena{174.606,141.526}`)

## Dugaan
OSINT geolocation dari foto artifact. Cek dulu **EXIF GPS** (`exiftool Whereami.jpeg`) — kalau ada GPS langsung jadi. Kalau nggak: identifikasi artifact/museum/situs dari visualnya → cari koordinat find-site-nya. Kirim `Whereami.jpeg`, gw cek EXIF + analisa.
