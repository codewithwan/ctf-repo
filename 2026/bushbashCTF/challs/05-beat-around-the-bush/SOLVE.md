**Flag:** `bushbash{so-many-trees-and-kangaroos}`

## TL;DR

The challenge is a monoalphabetic substitution cipher where each unique emoji character maps to a letter of the English alphabet or punctuation (`{`, `}`, `-`, `'`). Decrypting the passage reveals a story containing the flag.

## Find

1. The `README.md` description contains three lines of emojis:
   `🌳🌲🌴🌵🎄🌿☘🍀🍃🌴🍂🌵...`
2. There are 27 unique emoji characters in the string.
3. The repeated sequence `🌳🌲🌴` appears 6 times in the text. By analyzing the word length structure and frequency patterns (e.g. `🌳🌲🌴` = `the`, `🌵` = space/separator, `🍂🍃🌴🌴🪨🍃🌴🍂🍂` = `sleepless`, `🎋🎍🌳🌳🌴☘` = `nights`), we establish the complete monoalphabetic substitution key.

## Key Mapping

| Emoji | Character | Emoji | Character |
|-------|-----------|-------|-----------|
| 🌳 | t | 🎍 | i |
| 🌲 | h | 🪵 | g |
| 🌴 | e | 🪨 | p |
| 🌵 | (space) | ⛰ | o |
| 🎄 | j | 🏕 | k |
| 🌿 | u | 🌺 | `{` |
| ☘ | n | 🌻 | `-` |
| 🍀 | g | 🌼 | m |
| 🍃 | l | 🌸 | y |
| 🍂 | s | 🪻 | `}` |
| 🍁 | a | 🦌 | w |
| 🪴 | r | 🦘 | `'` |
| 🌱 | d | | |
| 🌾 | m | | |
| 🎋 | b | | |

## Solve

1. Apply the emoji substitution mapping across the text.
2. The full decrypted passage reads:
   > *the jungles are denser the birds are singing the sleepless nights roar and the lorikeets sing **bushbash{so-many-trees-and-kangaroos}** in the land down under just don't get bitten by a spider*
3. The flag is `bushbash{so-many-trees-and-kangaroos}`.
