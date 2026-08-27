**Flag:** `0xV0ID{1975_Bicentennial}`

## TL;DR
Four "Zodiac" letters all dated San Francisco 1971 — three carry the correct-era 8¢ Eisenhower stamp, but **letter_3.png** is franked with a **10¢ US flag stamp marked "1775 — 1975" / POSTAGE BICENTENNIAL**. That stamp series was issued in 1975 for the American Revolution Bicentennial, and 10¢ first-class rate itself didn't exist in 1971 (rate was 8¢ from May 1971, went to 10¢ only on Mar 2, 1974). Anachronism → letter 3 is the forgery.

## Find
- Challenge files not attached to CTFd `files[]`, but the challenge HTML has a `download_url` to `https://files.onebytectf.online/onebytectf/OSINT/letters.zip`. Pull it directly with curl.
- Archive contains `letter_1.png … letter_4.png`. All dated `San Francisco, Calif. — 1971`, all signed `— The Zodiac`.
- Only meaningful varying element between letters is the stamp in the top-right.

## Solve
1. `curl -sL -o letters.zip "https://files.onebytectf.online/onebytectf/OSINT/letters.zip" && unzip -o letters.zip`
2. Read each PNG, compare stamps.
   - L1, L2, L4: 8¢ Eisenhower silhouette definitive (Scott #1394, issued May 10 1971).
   - L3: **10¢ US flag, "1775 — 1975", "POSTAGE BICENTENNIAL"** — a Bicentennial-series stamp.
3. Cross-check historical facts:
   - **US first-class letter rate:** 6¢ until May 15 1971 → **8¢** May 16 1971 – Mar 1 1974 → **10¢** Mar 2 1974 – Dec 30 1975 → 13¢ Dec 31 1975. A 10¢ single-franking on a 1971 letter is impossible.
   - **"1775 — 1975" Bicentennial** commemoratives were issued starting 1975 for the 200th anniversary of Revolution-era events. Cannot exist in 1971.
4. `YEAR_NAME` per the flag format → issue year of the anachronistic stamp (1975) + the series name (Bicentennial).

## Verification
Flag `0xV0ID{1975_Bicentennial}` accepted on the platform.

## Reusable takeaway
For "spot the forgery" OSINT with dated correspondence: **the stamp is a dated artifact**. Cross-reference the shown denomination against the era's first-class rate table (USPS historical rates) and cross-reference any commemorative motif against its actual issue year — commemoratives can't predate the event they mark.
