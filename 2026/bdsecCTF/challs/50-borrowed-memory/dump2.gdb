set pagination off
starti
# find load base from the mapping of the binary
python
import re
b=gdb.execute("info proc mappings",to_string=True)
base=None
for line in b.splitlines():
    if 'borrowed' in line:
        base=int(line.split()[0],16); break
gdb.execute("set $base=%d"%base)
print("BASE 0x%x"%base)
end
break *($base+0x15fb)
commands
  silent
  printf "OFFSET 0x%x\n", ($rax & 0xffff)
  set $r8 = ($rax & 0xffff)
  continue
end
continue
quit
