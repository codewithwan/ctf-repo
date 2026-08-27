# Shadow Broker — DFIR (260) — IN PROGRESS (not solved)

**Q:** Telegram username + real name of the person who managed the suspect's escape, referred by R.
**Format:** `BDSEC{username_Name}` · Attempts 0/10 (nothing submitted yet)

## Who the person is (identified)
The escape broker = **Faisal**:
- Signal contact: **"Faisal (Documents & Travel)"** — handled new identity, travel docs, destination
  (Bangkok safe house, new name "Rahman Hossain"). Chat opens: *"R referred you to me. I understand
  you need a complete package..."*
- In the Telegram group **"Investment Discussion"** (id 1987654321) he is the **"Deleted Account"**
  `from_id = user323456789`, whose one operational line (2023-12-20) is:
  *"I can handle travel logistics for the right clients. R knows my rates. Discretion guaranteed."*
- Referred by **R** (R Consultant / Rajesh Patel — the mixing/logistics partner; confession:
  "Rajesh handled the mixing. Faisal made the documents").

## The blocker — his Telegram username + real name are DELETED
The Telegram account is deleted, so the export only shows "Deleted Account". Checked and came up empty:
- `home/arif.khan/AppData/Telegram/telegram_export.json` — 312 msgs, all cover-talk; broker anonymous.
- `.../tdata/usertag` — only arif's tag: `TelegramDesktop / UserID: ak_1982 / LastActive 2024-05-10`
  (note the username scheme: **initials + birth year**, ak = Arif Khan, 1982).
- Telegram `cache/`, `downloads/` — empty. salim's Telegram — empty.
- Signal export (Faisal chat) — no real name/username; Signal uses phone #s not TG usernames.
- WhatsApp (arif↔R Consultant), webmail (A. Reza/unknown321 emails only reference **Rajesh**, not Faisal).
- `contacts.db` (evolution addressbook) — empty.
- Disk-wide `grep 'Faisal'` — every hit is OS noise (Faisalabad, "King Faisal University",
  LibreOffice contributor "Faisal M. Al-Otaibi", etc.). No broker contact record.

## Next ideas to try (when we come back)
- Recover the **deleted TG account's** cached username/name: carve a Telegram peer cache / a fuller
  export (`result.json`) from **unallocated/slack** (the simplified `telegram_export.json` dropped it).
- Look for a **shared-contact vCard / t.me link** the broker or R sent (Downloads, Signal attachment
  that log says exists on 2024-05-11 "Message contains attachment" but folder is empty → carve it).
- The username likely follows the `ak_1982` pattern (initials_year) → find his real name first, then
  the username may be derivable/confirmable.
- Possibly a **live service** clue (like the webmail was) that hosts the broker's TG profile.

Image still mounted at `work/raw.img` (ext4 @ offset 1054720); webmail live at `http://50.116.30.77:5000`
(arif.khan@firstbangla.com / knightsquad4041337@).
