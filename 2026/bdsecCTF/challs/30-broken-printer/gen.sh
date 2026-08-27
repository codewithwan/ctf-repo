#!/bin/bash
for b in $(seq 32 126); do
  ch=$(printf "\\$(printf '%03o' $b)")
  printf '%.0s'"$ch" $(seq 1 42) > flag.txt
  out=$(./bp_patched 2>/dev/null | grep -aE '^[.:+#|/~]{40,}$')
  echo "$b|$out"
done
