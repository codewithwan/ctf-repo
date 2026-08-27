# SCADA Firmware Drift - Solve Writeup

## 1. Analisis Biner
File `firmware.bin` adalah file executable PE32+ (64-bit console) untuk Windows. 
Jika kita mengekstrak string dari file biner tersebut, ditemukan beberapa string menarik:
- `ACME3.7.1` (pada offset file `0x11b0`)
- `KEY42` (pada offset file `0x11c0`)
- `OBFUH` (pada offset file `0x11e4`)
- Obfuscated configuration payload berukuran 72 byte yang tersimpan di segment `.data`/`.rdata`.

## 2. Reverse Engineering Logika De-obfuscation
Dengan menggunakan disassembler, kita menemukan fungsi deobfuscasi pada alamat `0x100401090`:
```assembly
0x1004010b8:	mov	eax, ecx
0x1004010ba:	cdq	
0x1004010bb:	idiv	r9d          ; edx = index % strlen(key)
0x1004010be:	movsxd	rdx, edx
0x1004010c1:	movzx	eax, byte ptr [rdi + rdx] ; eax = key[index % key_len]
0x1004010c5:	xor	al, byte ptr [rbx + rcx]  ; al = data[index] ^ key[index % key_len]
0x1004010c8:	ror	al, 3        ; ror(al, 3)
0x1004010cb:	mov	byte ptr [rbx + rcx], al  ; data[index] = ror(al, 3)
```

Logika ini berjalan sebagai berikut untuk setiap byte data pada indeks `i`:
1. XOR byte data dengan byte kunci: `temp = data[i] ^ key[i % key_len]`
2. Lakukan Rotate Right (ROR) sebanyak 3 bit pada nilai `temp`: `result = ror(temp, 3)`
3. Simpan kembali `result` ke buffer.

Pada fungsi utama (`0x100401862`), rutin ini dipanggil dengan parameter:
- **Data**: Payload terenkripsi 72 byte (diambil dari `.rdata`)
- **Key**: Penunjuk ke string `KEY42` (panjang 5 byte)

## 3. Script Dekripsi
Kita dapat mengimplementasikan de-obfuscation routine di atas dalam Python untuk mendekripsi payload terenkripsi:
```python
def ror8(val, count):
    return (val >> count) | ((val << (8 - count)) & 0xff)

payload = bytes.fromhex(
    "d08ec2ce8160d6c27f4938acc0458b3acc598719386622a7db415f331e3268d6"
    "120791b1c652ff51304e7add39e80672473990de423f11eabf6a7fa120fe52a7"
    "19b1d6224f91a045"
)
key = b"KEY42"

decrypted = bytearray()
for i in range(len(payload)):
    val = payload[i] ^ key[i % len(key)]
    val = ror8(val, 3)
    decrypted.append(val)

print(decrypted.decode('utf-8'))
```

Hasil dekripsi menghasilkan konfigurasi berikut:
`sys_version=3.7.1 vendor=ACME drift_payload=athena{scad4_firmware_root} `

## Flag
`athena{scad4_firmware_root}`
