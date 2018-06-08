#!/bin/sh -e

ARCH=$1
SUITE=$2

#ARCH=mips64el
#SUITE=stretch

MIRROR=http://mirror.yandex.ru/debian
TGT=debian-$SUITE-$ARCH
QARCH=$(echo $ARCH | sed 's/^arm.*$/arm/')
QEMU=qemu-$QARCH-static

which $QEMU || apt-get install qemu-user-static
which debootstrap || apt-get install debootstrap

mkdir -p $TGT/usr/bin
cp $(which $QEMU) $TGT/usr/bin


## install base system
debootstrap --arch=$ARCH $SUITE $TGT $MIRROR

## copy configs
[ -f /etc/apt/apt.conf ] && cp /etc/apt/apt.conf $TGT/etc/apt/apt.conf
cp /etc/resolv.conf $TGT/etc/
echo  "deb $MIRROR $SUITE main contrib non-free" > $TGT/etc/apt/sources.list

cp stage2.sh $TGT/

## configure && install additional packages
mount -t proc none $TGT/proc
mount -o bind /dev $TGT/dev
mount -o bind /dev/pts $TGT/dev/pts
chroot $TGT /bin/bash /stage2.sh

umount $TGT/dev/pts $TGT/dev $TGT/proc
rm -f $TGT/etc/apt/apt.conf $TGT/etc/resolv.conf $TGT/stage2.sh

## create an archive
tar czf $TGT.tar.gz -C $TGT .
