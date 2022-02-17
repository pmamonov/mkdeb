# Build & use riscv64 Debian sid rootfs

Tested on Debian 11 (bullseye).

## Build

```
$ git clone https://github.com/pmamonov/mkdeb
$ cd mkdeb
$ sudo ./mkdeb.sh riscv64 sid http://mirror.yandex.ru/debian-ports
  ...
  New password: 
  Retype new password: 
  passwd: password updated successfully
  ...
$ ls
  debian-sid-riscv64 debian-sid-riscv64.tar.gz ...
```

## Use from chroot

```
$ T=./debian-sid-riscv64
$ sudo cp /etc/resolv.conf $T/etc/
$ sudo mount -t proc none $T/proc		## UNMOUNT BEFORE "rm -rf $T"!
$ sudo mount -o bind /dev $T/dev		## UNMOUNT BEFORE "rm -rf $T"!
$ sudo mount -o bind /dev/pts $T/dev/pts	## UNMOUNT BEFORE "rm -rf $T"!
$ sudo chroot $T /bin/bash

# uname -m
  riscv64
# cat /etc/debian_version
  bookworm/sid
# curl https://www.ports.debian.org/archive_2022.key | apt-key add -
# apt update
# exit

$ sudo umount $T/dev/pts $T/dev $T/proc
```

## Prepare disk image for QEMU (no MBR, hence "root=/dev/sda rw")

```
$ dd if=/dev/zero bs=1M count=4096 of=debian-sid-riscv64.img
$ /sbin/mkfs.ext4 debian-sid-riscv64.img
$ mkdir ./mnt
$ sudo mount -o loop debian-sid-riscv64.img ./mnt
$ sudo tar xf debian-sid-riscv64.tar.gz -C mnt/
$ sudo umount ./mnt
```
