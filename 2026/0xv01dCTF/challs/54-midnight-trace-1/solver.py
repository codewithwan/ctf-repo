#!/usr/bin/env python3
"""Midnight Trace - 1: pull ip / host / first payload from the pcap story."""
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

first = None
for ts, s, d, payload in frames('midnight_trace.pcap'):
    if payload:
        print(f'{ts} {s} -> {d}: {payload[:120]!r}')

# frames 1-3 tell the story
fs = [(s, d, p) for _, s, d, p in frames('midnight_trace.pcap') if p]
ext = None
for s, d, p in fs:
    if re.search(rb'cmd\.exe /c start (\S+)', p):
        ext = s
        payload = re.search(rb'cmd\.exe /c start (\S+)', p).group(1).decode()
        m = re.search(rb'host=(\S+)', p)
for s, d, p in fs:
    m = re.search(rb'host=(\S+) payload=(\S+)', p)
    if m:
        host, payload = m.group(1).decode(), m.group(2).decode()
        break
print(f'0xV01D{{{ext}_{host}_{payload}}}')
