# PCAP Secret - Solve Writeup

## 1. Decompressing the File
File `forensic_pcap_secret.pcap.gg` memiliki header Gzip (`1f 8b`). Kita lakukan decompress terlebih dahulu:
```bash
gzip -d -S .gg forensic_pcap_secret.pcap.gg
# atau rename dulu ke .gz lalu gzip -d
```
Hasil dekompresi menghasilkan file `forensic_pcap_secret.pcap`.

## 2. Analisis Traffic PCAP
Jika kita inspect printable strings pada file PCAP:
```http
POST /api/sync HTTP/1.1
Host: 198.51.100.24
User-Agent: curl/7.81.0
X-Sync-Token: YXRoZW5he3BjNHBfaDFkMzVfMW5fdzFyM30=
Content-Type: application/json
Content-Length: 31

{"host":"jump01","status":"ok"}
HTTP/1.1 204 No Content
```

Terdapat HTTP request `POST` ke `/api/sync` yang menyertakan header custom `X-Sync-Token: YXRoZW5he3BjNHBfaDFkMzVfMW5fdzFyM30=`.

## 3. Base64 Decode
Token tersebut di-decode dari Base64:
```bash
echo -n "YXRoZW5he3BjNHBfaDFkMzVfMW5fdzFyM30=" | base64 -d
```
Output:
`athena{pc4p_h1d35_1n_w1r3}`

## Flag
`athena{pc4p_h1d35_1n_w1r3}`
