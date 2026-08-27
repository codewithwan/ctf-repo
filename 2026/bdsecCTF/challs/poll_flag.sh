for i in $(seq 1 40); do
  r=$(python3 redispoll.py 2>/dev/null)
  f=$(echo "$r" | grep -oiE 'bdsec\{[^}]*\}')
  if [ -n "$f" ]; then echo "FOUND: $f" > flag_found.txt; echo "FOUND $f"; break; fi
  # also dump full state periodically
  echo "$(date +%H:%M:%S) $(echo "$r" | tr '\n' ' ')" >> poll_log.txt
  sleep 15
done
