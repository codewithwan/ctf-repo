set pagination off
set disable-randomization on
break *0x5555555555fb
commands
  silent
  printf "OFFSET 0x%x\n", ($rax & 0xffff)
  set $r8 = ($rax & 0xffff)
  continue
end
run
quit
