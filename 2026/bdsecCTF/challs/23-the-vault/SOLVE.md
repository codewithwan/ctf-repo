# The Vault — DFIR (175) [FBBL "Inside Job" series]

**Flag:** `BDSEC{F!rstB@ngla#Vault2024}` · verified "Correct" (challenge id 23)
**Question:** *The vault password collected by our system, stored in archive, and used to encrypt the suspect's Signal messages.*

## Where it comes from (three converging sources)
1. **pcap C2 exfil** (`var/captures/archived/network_capture.pcap`): the monitoring tool ("collected by
   our system") beacons to the Tor C2 and POSTs `/sync` with a hex→base64 body that decodes to
   `vault_key=F!rstB@ngla#Vault2024`.
2. **`opt/firstbangla/config/vault.conf`** hint: `Master password hint: F!rst + Bank_Name + #Vault + Year`
   → `F!rst` + `B@ngla` + `#Vault` + `2024` = `F!rstB@ngla#Vault2024`.
3. **It IS the Signal/confession encryption key.** `home/arif.khan/AppData/Signal/exports/signal_messages.json.enc`
   and `.confession.enc` are OpenSSL `Salted__` blobs; they decrypt with:
   ```bash
   openssl enc -d -aes-256-cbc -pbkdf2 -md sha256 -in signal_messages.json.enc -pass pass:'F!rstB@ngla#Vault2024'
   ```
   (default digest is sha256 since OpenSSL 1.1.0 — md5 fails.) Decrypts cleanly → confirms the password.

→ `BDSEC{F!rstB@ngla#Vault2024}`

## Reusable takeaway
Vault/keystore passwords planted across a DFIR image usually converge: an exfil capture, a config
"hint", and the actual crypto that consumes them. OpenSSL `Salted__` files → `-pbkdf2 -md sha256`
first; a clean decrypt is the confirmation you have the right password.
