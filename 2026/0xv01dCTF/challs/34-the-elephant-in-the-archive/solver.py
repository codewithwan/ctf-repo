#!/usr/bin/env python3
"""The Elephant in the Archive — OSINT on the Elephantine Colossus (Elephant Hotel), Coney Island.

The building in evidence.png is the Elephantine Colossus (a.k.a. Elephant
Hotel / Lucy's sibling) at Coney Island, NY — not Lucy (Margate, NJ), which
is the sibling that still survives today.

Five values, all from public sources:
 1. patent  : US 268503 — James V. Lafferty, "Building", granted 1882-12-05.
 2. room    : "through" — 1887 tourist guide: "1 through room from which the
              Elephant is feeding" (printed spelling preserved).
 3. days    : 120 — 1887 guide: 263 men and 120 full working days. Modern
              sources say 129, hence the "contemporary count conflicts" clue.
 4. school  : ps90 — P.S. 90, West 12th St, near the historical site
              (Coney Island History Project places the hotel across the street).
 5. fire    : 18960927 — burned Sunday evening Sept 27, 1896; the newspaper
              report ran Sept 28 (hence "not the next day's newspaper date").
"""
values = {
    "patent": "268503",
    "room": "through",
    "days": "120",
    "school": "ps90",
    "fire": "18960927",
}
flag = "0xV01D{%s_%s_%s_%s_%s}" % (
    values["patent"], values["room"], values["days"],
    values["school"], values["fire"])

for k, v in values.items():
    print(f"{k}: {v}")
print("FLAG:", flag)
