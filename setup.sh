#!/bin/sh
. /opt/farm/scripts/init

/opt/farm/scripts/setup/extension.sh sf-passwd-utils

echo "checking custom system groups"
/opt/farm/ext/passwd-utils/create-group.sh espeodev
/opt/farm/ext/passwd-utils/create-group.sh espeoadm


key=`/opt/farm/ext/keys/get-ssh-management-key-content.sh $HOST`
/opt/farm/ext/passwd-utils/add-key.sh root inline "$key"


/opt/farm/scripts/setup/extension.sh sf-mc-black
/opt/farm/scripts/setup/extension.sh sf-db-tools
/opt/farm/scripts/setup/extension.sh sf-app-deploy
/opt/farm/scripts/setup/extension.sh sf-circle


if  [ "$OSTYPE" = "amazon" ] || \
	[ "$OSVER" = "ubuntu-trusty" ] || \
	[ "$OSVER" = "ubuntu-xenial" ] || \
	[ "$OSVER" = "ubuntu-bionic" ] || \
	[ "$OSVER" = "debian-buster" ] || \
	[ "$OSVER" = "debian-stretch" ]; then
	dt=`date +"%Y.%m.%d %H:%M:%S"`
	echo "configuring /etc/sudoers.d/espeo file"
	echo "# Espeo Software custom sudoers list, last generated at $dt
%espeoadm ALL=(root) NOPASSWD: ALL
" >/etc/sudoers.d/espeo
fi
