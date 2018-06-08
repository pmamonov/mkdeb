#!/bin/sh

apt-get update || exit $?

apt-get purge systemd

apt-get -y install						\
	net-tools openssh-client openssh-server ntp		\
	vim make gcc gdb less					\
	slim i3 xscreensaver firefox-esr mutt gnupg		\
	rxvt-unicode screen minicom ipython			\
	firmware-realtek wicd-curses				\
	sysvinit-core						\
|| exit $?

passwd
