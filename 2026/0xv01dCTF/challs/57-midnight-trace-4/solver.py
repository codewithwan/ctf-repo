#!/usr/bin/env python3
"""Midnight Trace - 4: archive staged before the outbound relay connection."""
import struct, re

def frames(path):
    d = open(path, 'rb').read()
    off = 24
    while off + 16 <= len(d):
        ts, tus, caplen, origlen = struct.unpack('<IIII', d[off:off+16])
        pkt = d[off+16:off+16+caplen]
        off += 16 + caplen
        if len(pkt) < 34 or pkt[12:14] != b'\x08\x00':
            continue
        ip = pkt[14:]
        ihl = (ip[0] & 0xF) * 4
        s = '.'.join(str(b) for b in ip[12:16]); d_ = '.'.join(str(b) for b in ip[16:20])
        payload = b''
        if ip[9] == 6 and len(ip) >= ihl + 20:
            payload = ip[ihl+20:]
        yield ts, s, d_, payload

# SMB create of the staged archive (frame 14) precedes the outbound relay (frame 22+).
for ts, s, d, p in frames('midnight_trace.pcap'):
    if b'SMB2 CREATE file=' in p:
        print(f'{ts} {s} -> {d}: {p[:160]!r}')
        m = re.search(rb'([A-Za-z0-9_]+[.]7z)', p)
        print(f'0xV01D{{{m.group(1).decode()}}}')
        break
