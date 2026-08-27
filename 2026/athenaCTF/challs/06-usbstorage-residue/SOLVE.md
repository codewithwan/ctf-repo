# USBStorage Residue — SOLVED

**Flag:** `athena{62d635d2c2f5bf36c7b78859069fd818}`

(decoy di versi lama: `athena{n0t_th3_r34l_fl4g}` — jangan ketipu)

- **Category:** FORENSICS
- **File:** `usbstorage_rotated.pcap.gz`

## Recon
- pcap link type = LINKTYPE_USER0 (147) → "no dissector will touch". Frame = raw
  **USB Mass-Storage Bulk-Only Transport (BBB)**: `USBC` = CBW (Command Block Wrapper),
  `USBS` = CSW (Status Wrapper), di antaranya data phase.
- Parse manual: tiap CBW punya SCSI CDB. Cari opcode `0x2A` = **WRITE(10)** → ambil LBA
  (CDB[2:6] BE) + transfer length + data phase.

## Write pattern
11 write ke region kontigu LBA `0x90bb50..0x90bb64` (5 chunk × 2048B ≈ 10KB), tiap LBA
ditulis **2×**:
- occurrence ke-1 tiap LBA = **v1** (file original)
- occurrence ke-2 = **v2** (newer copy / "replaced")
- + 1 write 1-block terakhir ke 0x90bb50 = "removed" (metadata).

pcap nangkep **kedua** versi → reconstruct dua-duanya (assemble by sorted LBA).

## Reconstruct & carve
Kedua image = **POSIX tar** berisi `flag.gz`:
```bash
tar xf recovered_v1.bin -C ex_v1 && gzip -dc ex_v1/flag.gz  # -> decoy
tar xf recovered_v2.bin -C ex_v2 && gzip -dc ex_v2/flag.gz  # -> real flag
```
- v1 (original, ketiban) → `athena{n0t_th3_r34l_fl4g}` (umpan)
- v2 (newer copy = si "deleted file") → `athena{62d635d2c2f5bf36c7b78859069fd818}` ✅

## Artefak
- `parse.py` — parser BOT + reconstruct
- `recovered_v1.bin` / `recovered_v2.bin` — tar hasil rekonstruksi
- `ex_v1/flag.out`, `ex_v2/flag.out` — log ter-decompress
