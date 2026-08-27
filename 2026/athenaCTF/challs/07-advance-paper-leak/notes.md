# Advance Paper Leak — OSINT trail (BELUM solved, kepentok login wall)

Clue: "We are claming the paper leak. leak code #Athenafl"

## Yang udah dipetain
- Penyelenggara: **AstraQ Cyber Defence** (Akola, India). Founder: Raj Pundkar.
- Instagram @athena_ctf & @astraq_cd → cuma post countdown promo, TIDAK ada #Athenafl.
- X founder @rajpundkar → bio: "Building @AstraQCD".
- **X resmi org: @AstraqCD** → punya **4 posts**, TAPI X sembunyiin timeline dari
  visitor yang gak login. Syndication API rate-limited, nitter/xcancel kena anti-bot.

## Dugaan (paling mungkin)
Flag ada di salah satu dari 4 tweet @AstraqCD (atau hasil search hashtag **#Athenafl**
di X), kemungkinan "leaked paper" berupa gambar/teks yang memuat athena{...}.

## Langkah manual (butuh akun X yang login)
1. Login X → buka https://x.com/AstraqCD (atau search `#Athenafl`).
2. Cari post "paper leak" → flag di teks/gambar/komentar.
3. Kalau ketemu gambar/encoded, kirim ke Claude buat decode/verify.
