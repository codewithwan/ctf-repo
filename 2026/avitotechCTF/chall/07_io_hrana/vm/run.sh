#!/bin/sh
set -e
mkdir -p irfs/bin
cp busybox irfs/bin/busybox; cp io_hrana.elf irfs/io_hrana.elf; cp init irfs/init
# copy any extra files staged in extra/
if [ -d extra ]; then cp -a extra/. irfs/ 2>/dev/null || true; fi
chmod +x irfs/init irfs/bin/busybox irfs/io_hrana.elf
( cd irfs && find . | cpio -o -H newc 2>/dev/null | gzip ) > initramfs.gz
echo "=====BOOT====="
qemu-system-x86_64 -M q35 -m 512 -nographic -no-reboot -accel tcg \
  -kernel bzImage -initrd initramfs.gz \
  -append "console=ttyS0 panic=1 loglevel=3" 2>&1 | tr -d "\r"
echo "=====QEMU_DONE====="
