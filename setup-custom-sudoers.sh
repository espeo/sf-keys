#!/bin/sh
. /opt/farm/scripts/init

if [ -f /etc/sudoers.d/espeo ] && [ "`which lsattr 2>/dev/null`" != "" ] && [ "`lsattr -l /etc/sudoers.d/espeo |grep Immutable`" != "" ]; then
	echo "skipping sudoers setup, file is already configured and immutable"
	exit 0
fi

if  [ "$OSTYPE" = "amazon" ] || \
	[ "$OSVER" = "raspbian-jessie" ] || \
	[ "$OSVER" = "raspbian-buster" ] || \
	[ "$OSVER" = "raspbian-stretch" ] || \
	[ "$OSVER" = "ubuntu-trusty" ] || \
	[ "$OSVER" = "ubuntu-xenial" ] || \
	[ "$OSVER" = "ubuntu-bionic" ] || \
	[ "$OSVER" = "debian-jessie" ] || \
	[ "$OSVER" = "debian-buster" ] || \
	[ "$OSVER" = "debian-stretch" ]; then
	dt=`date +"%Y.%m.%d %H:%M:%S"`
	echo "configuring /etc/sudoers.d/espeo file"
	echo "# Espeo Software custom sudoers list, last generated at $dt
%espeoadm ALL=(root) NOPASSWD: ALL
" >/etc/sudoers.d/espeo
fi
