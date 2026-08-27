#!/usr/bin/env python3

import re
import os
import shutil
import subprocess
import sys

try:
    from z3 import Int, Or, Solver, sat
except ModuleNotFoundError:
    pyenv = shutil.which("pyenv")
    if not pyenv:
        raise
    python = subprocess.check_output([pyenv, "which", "python3"], text=True).strip()
    if os.path.realpath(python) == os.path.realpath(sys.executable):
        raise
    os.execv(python, [python, *sys.argv])


SOURCE = "out.cpp"


def split_args(s):
    out = []
    cur = []
    depth = 0
    for ch in s:
        if ch == "<":
            depth += 1
        elif ch == ">":
            depth -= 1
        if ch == "," and depth == 0:
            out.append("".join(cur).strip())
            cur = []
        else:
            cur.append(ch)
    out.append("".join(cur).strip())
    return out


def main():
    text = open(SOURCE).read()
    lines = re.findall(r"using Constraint_\d+ = (\w+)<(.*?)>;", text)
    n = max(map(int, re.findall(r"FlagValue<(\d+)>::Value", text))) + 1
    vals = [Int(f"v{i}") for i in range(n)]

    def expr(s):
        s = re.sub(r"FlagValue<(\d+)>::Value", lambda m: f"vals[{m.group(1)}]", s)
        if not re.fullmatch(r"[vals\[\]\d\s+\-*/()%]+", s):
            raise ValueError(s)
        return eval(s, {"__builtins__": {}}, {"vals": vals})

    solver = Solver()
    for val in vals:
        solver.add(val >= 0, val <= 255)

    for op, args_s in lines:
        args = split_args(args_s)
        if op == "Equ":
            c1, c2, t1, v1, v2, v3, v4, v5 = map(expr, args)
            solver.add(c1 * v1 + c2 * v2 + t1 * v3 == v4 + v5)
        elif op == "Lt":
            solver.add(expr(args[0]) < expr(args[1]))
        elif op == "Lteq":
            solver.add(expr(args[0]) <= expr(args[1]))
        elif op == "Gt":
            solver.add(expr(args[0]) > expr(args[1]))
        elif op == "Gteq":
            solver.add(expr(args[0]) >= expr(args[1]))
        elif op == "Divides":
            solver.add(expr(args[0]) % expr(args[1]) == 0)
        else:
            raise ValueError(op)

    if solver.check() != sat:
        raise RuntimeError("constraints are unsat")

    model = solver.model()
    solution = [model[val].as_long() for val in vals]
    message = bytes(solution).decode()
    print(message)

    solver.add(Or([val != solution[i] for i, val in enumerate(vals)]))
    print("unique:", solver.check() != sat)


if __name__ == "__main__":
    main()
