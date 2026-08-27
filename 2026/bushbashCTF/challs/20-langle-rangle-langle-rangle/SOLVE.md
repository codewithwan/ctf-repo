# langle-rangle-langle-rangle

Flag: `bushbash{d1d_y0U_Us3_z3?}`

`out.cpp` defines 214 `FlagValue` bytes and 1581 template constraints. The
constraint structs map directly to arithmetic predicates:

- `Lt`, `Lteq`, `Gt`, `Gteq` are integer comparisons.
- `Divides<L, R>` means `L % R == 0`.
- `Equ<c1, c2, t1, v1, v2, v3, v4, v5>` means
  `c1*v1 + c2*v2 + t1*v3 == v4 + v5`.

`solver.py` parses those template instantiations into Z3 over byte variables.
The model is unique and decodes to:

```text
Congratulations on solving the challenge! (Yes I am having more text in here to make the challenge harder). I can't believe somebody beat a similar challenge last ctf manually. The flag is bushbash{d1d_y0U_Us3_z3?}
```
