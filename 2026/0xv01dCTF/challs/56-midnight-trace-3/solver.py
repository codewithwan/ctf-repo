#!/usr/bin/env python3
"""Midnight Trace - 3: first authenticated SMB identity (domain_user_host)."""
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

for ts, s, d, p in frames('midnight_trace.pcap'):
    if b'NTLMSSP_AUTH' in p or b'SESSION_SETUP' in p:
        print(f'{ts} {s} -> {d}: {p[:200]!r}')
    m = re.search(rb'Domain=(\S+) User=(\S+).*?Target=(\S+)', p)
    if m:
        domain, user, host = (m.group(i).decode() for i in (1, 2, 3))
        print(f'0xV01D{{{domain}_{user}_{host}}}')
        break
