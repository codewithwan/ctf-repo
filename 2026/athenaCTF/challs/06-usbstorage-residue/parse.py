import struct
data=open("work","rb").read()
assert data[:4]==b'\xd4\xc3\xb2\xa1'
off=24
frames=[]
while off+16<=len(data):
    ts_s,ts_u,incl,orig=struct.unpack('<IIII',data[off:off+16])
    off+=16
    frames.append(data[off:off+incl])
    off+=incl
print("frames:",len(frames))

# Walk BOT: CBW -> data phase -> CSW
i=0
writes=[]  # (lba, blocks, data)
reads=[]
cmds=[]
while i<len(frames):
    f=frames[i]
    if f[:4]==b'USBC':
        tag=struct.unpack('<I',f[4:8])[0]
        dlen=struct.unpack('<I',f[8:12])[0]
        flags=f[12]
        cblen=f[14]
        cdb=f[15:15+cblen]
        op=cdb[0] if cdb else None
        cmds.append((op,dlen,flags))
        # gather data phase from following frames until we've got dlen bytes or hit CSW
        payload=b''
        j=i+1
        while j<len(frames) and len(payload)<dlen:
            nf=frames[j]
            if nf[:4]==b'USBS': break
            payload+=nf
            j+=1
        if op==0x2a and cblen>=10: # WRITE(10)
            lba=struct.unpack('>I',cdb[2:6])[0]
            blocks=struct.unpack('>H',cdb[7:9])[0]
            writes.append((lba,blocks,payload[:dlen]))
        elif op==0x28 and cblen>=10: # READ(10)
            lba=struct.unpack('>I',cdb[2:6])[0]
            blocks=struct.unpack('>H',cdb[7:9])[0]
            reads.append((lba,blocks,payload[:dlen]))
        i=j
    else:
        i+=1

from collections import Counter
print("cmd opcodes:", Counter(hex(c[0]) if c[0] is not None else 'none' for c in cmds))
print("num writes:",len(writes),"num reads:",len(reads))
for w in writes:
    print(f"  WRITE lba=0x{w[0]:x} blocks={w[1]} datalen={len(w[2])}")

# Reconstruct: order writes, first occurrence per LBA = v1, second = v2
from collections import defaultdict
occ=defaultdict(list)
for lba,blocks,payload in writes:
    occ[lba].append(payload)

lbas=sorted(k for k in occ if len(occ[k][0])==2048)
def build(ver):
    out=b''
    for lba in lbas:
        vs=occ[lba]
        out+= vs[ver] if ver<len(vs) else vs[-1]
    return out
v1=build(0); v2=build(1)
open("recovered_v1.bin","wb").write(v1)
open("recovered_v2.bin","wb").write(v2)
print("v1 len",len(v1),"v2 len",len(v2))
for name,b in [("v1",v1),("v2",v2)]:
    print(f"--- {name} head ---", b[:16].hex(), "| ascii:", ''.join(chr(c) if 32<=c<127 else '.' for c in b[:24]))
