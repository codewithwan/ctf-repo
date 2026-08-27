#!/usr/bin/env python3
"""Midnight Trace - 2: first internal pivot hostname from the pcap story."""
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

fs = [(s, d, p) for _, s, d, p in frames('midnight_trace.pcap') if p]

# discovery: WEB01 (10.63.20.17) resolves dc01 / ops-jump02 / vault01 (frames 4-9),
# then contacts ops-jump02 (10.63.30.44:22) which answers "pivot ok hostname=ops-jump02".
hostname = None
for s, d, p in fs:
    m = re.search(rb'hostname=(\S+)', p)
    if m:
        hostname = m.group(1).decode()
        break
print('pivot hostname:', hostname)
print(f'0xV01D{{{hostname}}}')
