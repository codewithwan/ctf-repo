# Feed a program (prog.json) to the real binary via docker amd64 and print output.
import json,subprocess,sys
prog=json.load(open('prog.json'))
lines=[]
for (o,d,a) in prog:
    if o in ('SWAP','MIX'): lines.append(f"{o} R{d} R{a}")
    else: lines.append(f"{o} R{d} {a}")
inp="\n".join(lines)+"\nRUN\n"
sys.stderr.write("PROGRAM:\n"+inp+"\n---\n")
out=subprocess.run(["docker","run","--rm","-i","--platform","linux/amd64","-v",__import__('os').getcwd()+":/work","-w","/work","ubuntu:22.04","./fourreg"],input=inp.encode(),capture_output=True,timeout=120)
print(out.stdout.decode('latin1',errors='replace'))
if out.stderr: sys.stderr.write(out.stderr.decode('latin1',errors='replace'))
