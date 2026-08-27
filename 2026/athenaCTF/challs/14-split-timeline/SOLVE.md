# Split Timeline - Solve Writeup

## 1. Analisis Artifact
Tantangan memberikan 3 file:
- `setupapi.dev.log`
- `mft.bin`
- `usnjrnl.bin`

### setupapi.dev.log
Dari log instalasi device USB, kita mengidentifikasi 3 USB storage device yang dicolokkan pada pagi hari 2026/05/19:
1. **SanDisk Cruzer Blade**: Serial `4C530001180529117094` (terkoneksi pukul **06:41:02**)
2. **SanDisk Ultra Fit**: Serial `AA010129180916122757` (terkoneksi pukul **07:13:11**)
3. **Kingston DataTraveler 3.0**: Serial `E0D55EA5730CF0507A2C0E1B` (terkoneksi pukul **07:46:12**)

### mft.bin
Dari pembacaan MFT, ditemukan script PowerShell `stage.ps1` yang digunakan untuk menyembunyikan payload:
```powershell
# stage.ps1 -- block out $Target and park it in ADS until the courier run
$s = (gwmi Win32_DiskDrive | ? {$_.InterfaceType -eq 'USB'} | select -f 1).SerialNumber
# encrypt once over the whole file, then cut the ciphertext into blocks
$c = RC4 $s ([IO.File]::ReadAllBytes($Target))
for ($i = 0; $i -lt $c.Length; $i += 5) {
  $b = $c[$i..([Math]::Min($i + 4, $c.Length - 1))]
  $t = "$env:TEMP\~df{0:X4}.tmp" -f (Get-Random -Max 0xFFFF)
  sc $t 'tmp scratch block; superseded'
  [IO.File]::WriteAllBytes("${t}:sync", $b)
  $f = gi $t -Force
  $f.CreationTime = $Blend
  $f.LastWriteTime = $Blend
```
Script tersebut mengenkripsi file target menggunakan algoritma **RC4** dengan key **Serial Number** USB device yang dicolokkan. Hasil enkripsi kemudian dipecah menjadi blok-blok berukuran **5 byte** dan disimpan di Alternate Data Stream (ADS) bernama `:sync` pada file-file temporer `$env:TEMP\~dfXXXX.tmp`.

Parsing MFT terhadap record `~df*.tmp` berhasil mengekstrak isi ADS `:sync` (yang tersimpan secara resident di MFT karena ukurannya kecil):
- `~dfA31C.tmp` $\rightarrow$ `3d02f4f40a`
- `~df77E2.tmp` $\rightarrow$ `738c3400c5`
- `~df1B04.tmp` $\rightarrow$ `3b9703e9c3`
- `~df9C55.tmp` $\rightarrow$ `1458f1a19a`
- `~df6D0B.tmp` $\rightarrow$ `fea40f6d24`
- `~dfC418.tmp` $\rightarrow$ `6bca5e56b1`
- `~df3F9A.tmp` $\rightarrow$ `ccd98719fd`
- `~df90E7.tmp` $\rightarrow$ `bac460fab4`
- `~df2E81.tmp` $\rightarrow$ `a70e4a1f41`
- `~df4A19.tmp` $\rightarrow$ `d60334687c`
- `~dfB730.tmp` $\rightarrow$ `f396e70bf9`
- `~df08CD.tmp` $\rightarrow$ `6577babc28`
- `~df5F62.tmp` $\rightarrow$ `77a6a83940`
- `~dfE394.tmp` $\rightarrow$ `c778f44a21`

### usnjrnl.bin
Dari hasil parsing USN Journal (`usnjrnl.bin`), kita mengidentifikasi urutan kronologis pembuatan file-file `~df*.tmp` tersebut:
- **Session 1 (06:41:09)** - Berhubungan dengan **SanDisk Cruzer Blade**:
  `~dfA31C.tmp` $\rightarrow$ `~df77E2.tmp` $\rightarrow$ `~df1B04.tmp` $\rightarrow$ `~df9C55.tmp` $\rightarrow$ `~df6D0B.tmp` $\rightarrow$ `~dfC418.tmp` $\rightarrow$ `~df3F9A.tmp` $\rightarrow$ `~df90E7.tmp`
- **Session 2 (07:13:12)** - Berhubungan dengan **SanDisk Ultra Fit**:
  `~df2E81.tmp` $\rightarrow$ `~df4A19.tmp` $\rightarrow$ `~dfB730.tmp` $\rightarrow$ `~df08CD.tmp` $\rightarrow$ `~df5F62.tmp` $\rightarrow$ `~dfE394.tmp`

## 2. Dekripsi Payload
Kita menggabungkan blok ciphertext sesuai urutan waktu USN Journal, lalu mendekripsinya dengan RC4 menggunakan Serial Number USB yang sesuai sebagai key.

- **Session 1 Decrypted** (Key: `4C530001180529117094`):
  `staging selftest ok; no payload attached` (Ini hanya selftest)
  
- **Session 2 Decrypted** (Key: `AA010129180916122757`):
  `athena{mft_records_tell_tales}` (Ini adalah flag target!)

## Flag
`athena{mft_records_tell_tales}`
