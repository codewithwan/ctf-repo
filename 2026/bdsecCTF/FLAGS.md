# BDSec CTF 2026 — FLAGS

Flag format: BDSEC{...}
Team: Cyb0x1 (id 277) | User: TahuCryptsi (591)

| # | Challenge | Category | Flag | Status |
|---|-----------|----------|------|--------|
| 4 | Easy RE Challenge | Reverse Engineering | `BDSEC{e4SY_r3v3rS3_eNg1N33r1nG_cH4LL4ng3}` | SOLVED (verified) |
| 28 | Admin Portal | Web | `bdsec{n0ne_4lg_m34ns_n0_s1gn4tur3}` | SOLVED (verified, JWT alg:none) |
| 40 | Muktir Shongket | Pwn | `BDSEC{mukt1r_5h0ngk3t_r34ch3d_th3_f13ld}` | SOLVED (verifier/JIT differential) |
| 50 | Borrowed Memory | Reverse Engineering | `BDSEC{p01nt3rs_l13_bUt_0ffs3ts_r3m3mb3r}` | SOLVED (verified, chain-walk) |
| 60 | Cold Start | Reverse Engineering | `BDSEC{th3_k3y_w4s_s0m3wh3r3_1n_16_m1ll10n}` | SOLVED (24-bit brute) |
| 70 | Crack Me Vault | Reverse Engineering | `BDSEC{c0nTr0L_fl0w_1s_4_l13_bUt_bYt3c0d3_d03s_n0t}` | SOLVED (VM invert) |
| 80 | Ekusher Shobdo | PWN & Jail | `BDSEC{sh0bd0_k0kh0n0_b0nd1_th4k3_n4}` | SOLVED (C++ vtable hijack) |
| 90 | Phantom Device | PWN & Jail | `BDSEC{ph4nt0m_h4ndl35_n3v3r_d13}` | SOLVED (UAF + token forge) |
| 32 | Partner Sync | Web | `BDSEC{Y0U_D0nE_4ll_st3ps}` | SOLVED (verified, SSRF→proto-RCE→dind escape) |
| 20 | Unauthorized Access | DFIR | `BDSEC{45.33.32.156}` | SOLVED (verified, OVA→ext4 carve→treasury auth log brute-force) |
| 22 | Paper Trail | DFIR | `BDSEC{knightsquad4041337@_unknown321@protonmail.com}` | SOLVED (verified, Firefox NSS decrypt→live webmail login→inbox) |
| 23 | The Vault | DFIR | `BDSEC{F!rstB@ngla#Vault2024}` | SOLVED (verified, pcap C2 exfil vault_key = Signal enc key) |
| 24 | Ghost Signal | DFIR | `BDSEC{185.220.101.47_13.8703066_100.5928967}` | SOLVED (verified, pcap C2 beacon + Telegram location msg) |
| 30 | Broken Printer | Rev | `BDSEC{th3_pr1nt3r_d03s_n0t_pr1nt_1n_0rd3r}` | SOLVED (decoded; submit pending CF) — patch-key oracle + codebook |
