d=open('vault','rb').read(); tgt=d[0x22c0:0x22c0+50]
ror8=lambda v,r:((v>>(r&7))|(v<<(8-(r&7))))&0xff
f=bytearray(50)
for i in range(50):
    t=((tgt[i]^((0x44+0xd*i)&0xff))-((0xb*i)^0x17))&0xff
    f[i]=(ror8(t,(i%7)+1)^((0x41+0x1d*i)&0xff))&0xff
print(f.decode())
