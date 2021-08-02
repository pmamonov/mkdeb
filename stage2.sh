#!/bin/sh

apt-get update || exit $?

apt-get -y --force-yes install					\
	net-tools openssh-client openssh-server ntp		\
	vim make gcc gdb less					\
	slim xfce4 firefox-esr					\
|| exit $?

passwd
