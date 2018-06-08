#!/bin/sh

apt-get update || exit $?

apt-get purge systemd

apt-get -y install						\
	net-tools openssh-client openssh-server ntp		\
	vim make gcc gdb less					\
	slim xfce4 firefox-esr					\
	sysvinit-core						\
|| exit $?

passwd
