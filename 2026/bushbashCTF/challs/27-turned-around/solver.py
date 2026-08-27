#!/usr/bin/env python3

import re


SOURCE = "turnedaround.bf"


def bracket_map(code):
    stack = []
    jumps = {}
    loops = []
    for i, ch in enumerate(code):
        if ch == "[":
            stack.append(i)
        elif ch == "]":
            start = stack.pop()
            jumps[start] = i
            jumps[i] = start
            loops.append((start, i))
    return jumps, loops


def run_segment(code, jumps, start, end, limit=2_000_000):
    local_jumps = {
        k: v for k, v in jumps.items()
        if start <= k < end and start <= v < end
    }
    tape = [0] * 1000
    ptr = 200
    tape[ptr] = 1
    ip = start
    out = []
    steps = 0
    while start <= ip < end and steps < limit:
        op = code[ip]
        steps += 1
        if op == ">":
            ptr += 1
        elif op == "<":
            ptr -= 1
        elif op == "+":
            tape[ptr] = (tape[ptr] + 1) & 255
        elif op == "-":
            tape[ptr] = (tape[ptr] - 1) & 255
        elif op == ".":
            out.append(tape[ptr])
        elif op == "[" and tape[ptr] == 0:
            ip = local_jumps[ip]
        elif op == "]" and tape[ptr] != 0:
            ip = local_jumps[ip]
        ip += 1
    return bytes(out).decode("latin1", errors="ignore")


def main():
    code = "".join(ch for ch in open(SOURCE).read() if ch in "<>+-.,[]")
    jumps, loops = bracket_map(code)

    messages = []
    for start, end in loops:
        if "." not in code[start:end]:
            continue
        msg = run_segment(code, jumps, start + 1, end)
        if "password" in msg:
            messages.append(msg.strip())

    print("\n".join(messages))
    first = re.search(r"partial password: ([^_]+)", "\n".join(messages)).group(1)
    second = re.search(r"_+([^_\\n]+)$", "\n".join(messages)).group(1)
    password = first + second
    print(f"bushbash{{{password}}}")


if __name__ == "__main__":
    main()
