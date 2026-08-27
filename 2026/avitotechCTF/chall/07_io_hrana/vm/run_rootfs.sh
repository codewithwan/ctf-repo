#!/bin/sh
set -e
( cd rootfs && find . 2>/dev/null | cpio -o -H newc 2>/dev/null | gzip ) > initramfs_rootfs.gz
echo "=====BOOT====="
qemu-system-x86_64 -M q35 -m 640 -nographic -no-reboot -accel tcg \
  -kernel bzImage -initrd initramfs_rootfs.gz \
  -append "console=ttyS0 panic=1 loglevel=3 rdinit=/initc pid1name=systemd" 2>&1 | tr -d "\r"
echo "=====QEMU_DONE====="
