# The Elephant in the Archive

**Status:** solved

**Flag:** `0xV01D{268503_through_120_ps90_18960927}` (recovered from public-source research; not submitted)

**Technique tags:** osint, image identification, historical research, patent lookup

**Signals:** 1896 building that "barely looked like a building", a surviving "relative", modern sources disagreeing about numbers/dates, and five ordered values (patent / room label / working days / school / fire date) with the warning that the fire date is not the newspaper date.

**Identification:** `evidence.png` shows the **Elephantine Colossus / Elephant Hotel** at Coney Island, NY — designed by James V. Lafferty, the same architect as **Lucy** (Margate, NJ), which is the sibling that still survives. (Not Lucy itself.)

## Values
1. **Patent:** US **268503** — "Building", granted to James V. Lafferty on Dec. 5, 1882.
2. **Room:** **through** — the 1887 tourist guide reads "1 through room from which the Elephant is feeding"; the printed spelling is preserved (not "thru").
3. **Working days:** **120** — the 1887 guide says 263 men and 120 full working days. Modern sources (e.g. Lucy's official history) say 129 — hence "contemporary count conflicts".
4. **School:** **ps90** — P.S. 90 (West 12th St); the Coney Island History Project places the hotel elephant across the street from the school site. Normalized as `ps90`.
5. **Fire:** **18960927** — burned Sunday evening, Sept. 27, 1896; the newspaper report ran Sept. 28, so the clue warns to use the fire date itself, not the next day's paper.

## Method
- Identify the building from evidence.png (Elephant Hotel, Coney Island; Lafferty also built Lucy — the surviving sibling).
- Look up Lafferty's US patent for the animal-shaped building (268503, 1882-12-05).
- Pull the 1887 tourist guide text for the feeding-room label and the construction stats (263 men / 120 full working days).
- Cross-reference the historical site with current NYC school geography (P.S. 90).
- Confirm the fire date from contemporary reporting (Sept. 27, 1896 evening fire; Sept. 28 newspaper).

## Solve
`solver.py` prints the five values and the flag.
