#!/usr/bin/env python3

import socket


HOST = "34.40.133.67"
PORT = 6768


def cobs_encode(data):
    out = bytearray()
    idx = 0
    while idx < len(data):
        nxt = data.find(b"\0", idx)
        if nxt == -1:
            nxt = len(data)
        block = data[idx:nxt]
        while len(block) >= 254:
            out.append(0xFF)
            out += block[:254]
            block = block[254:]
        out.append(len(block) + 1)
        out += block
        idx = nxt + 1
        if nxt == len(data):
            break
    if data.endswith(b"\0"):
        out.append(1)
    return bytes(out)


def cobs_decode(frame):
    out = bytearray()
    idx = 0
    while idx < len(frame):
        code = frame[idx]
        idx += 1
        out += frame[idx:idx + code - 1]
        idx += code - 1
        if code < 0xFF and idx < len(frame):
            out.append(0)
    return bytes(out)


def recv_frames(sock):
    sock.settimeout(1)
    buf = bytearray()
    frames = []
    while True:
        try:
            chunk = sock.recv(4096)
        except (TimeoutError, socket.timeout):
            break
        if not chunk:
            break
        buf += chunk
        while 0 in buf:
            pos = buf.index(0)
            frames.append(bytes(buf[:pos]))
            del buf[:pos + 1]
    return [cobs_decode(frame).decode() for frame in frames if frame]


def send_frame(sock, text):
    sock.sendall(cobs_encode(text.encode()) + b"\0")


def main():
    with socket.create_connection((HOST, PORT), timeout=5) as sock:
        print("\n".join(recv_frames(sock)))
        send_frame(sock, "admin")
        print("\n".join(recv_frames(sock)))
        send_frame(sock, "password")
        print("\n".join(recv_frames(sock)))


if __name__ == "__main__":
    main()
