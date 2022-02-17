#!/bin/sh

apt-get update || exit $?

apt-get -y --force-yes install					\
	curl net-tools openssh-client openssh-server ntp	\
	vim make gcc gdb less gnupg				\
|| exit $?

passwd
