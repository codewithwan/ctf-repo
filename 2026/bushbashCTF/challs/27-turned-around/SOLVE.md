# Turned Around

Flag: `bushbash{(d0Ub13*-*b4ck!}`

Running the Brainfuck normally only prints a decoy:

```text
Nice try! Unfortunately it's not that easy...
```

The useful strings are inside branches that are skipped because their guard
cell is zero. Several skipped loop bodies begin with `[-]`, so forcing the guard
cell to one makes the body run once after clearing the guard.

`solver.py` parses matching bracket ranges, runs loop bodies in isolation, and
extracts the two password notes:

```text
Core Dumped! Recovered partial password: (d0Ub13*_______
TODO: Remove this note where I hide half my hidden password: ________-*b4ck!
```

Combining the visible halves gives `(d0Ub13*-*b4ck!`, so the flag is
`bushbash{(d0Ub13*-*b4ck!}`.
