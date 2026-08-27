exec >/dev/console 2>&1
echo "=====CLEAN_RUN====="
printf 'testinput\n' | /io_hrana.elf
echo "=====CLEAN_EXIT=$?====="
echo "=====STRACE_RUN====="
printf 'testinput\n' | strace -f -e trace=openat,readlinkat,read -s 300 /io_hrana.elf 2>/tmp/s.out >/tmp/o.out
echo "=====STRACE_EXIT=$?====="
echo "--- stdout ---"; cat /tmp/o.out
echo "--- openat (non-lib) ---"
grep -aE "openat" /tmp/s.out | grep -avE "ld-musl|/lib/|/usr/lib|locale|gconv|ld.so.cache|/proc/self/exe|/etc/ld" 
echo "--- reads of proc/1/comm and small reads ---"
grep -aE '/proc/1/comm|read\(4,|read\(5,|read\(6,' /tmp/s.out | head -20
