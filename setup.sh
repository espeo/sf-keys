#!/bin/sh
. /opt/farm/scripts/init

/opt/farm/scripts/setup/extension.sh sf-passwd-utils

key=`/opt/farm/ext/keys/get-ssh-management-key-content.sh $HOST`
/opt/farm/ext/passwd-utils/add-key.sh root inline "$key"


echo "checking custom system groups"
/opt/farm/ext/passwd-utils/create-group.sh espeodev
/opt/farm/ext/passwd-utils/create-group.sh espeoadm

/opt/farm/scripts/setup/extension.sh sf-mc-black
/opt/farm/scripts/setup/extension.sh sf-db-tools
/opt/farm/scripts/setup/extension.sh sf-app-deploy
/opt/farm/scripts/setup/extension.sh sf-circle


if [ "$OSVER" = "ubuntu-trusty" ] || [ "$OSVER" = "ubuntu-xenial" ] || [ "$OSVER" = "ubuntu-bionic" ]; then
	dt=`date +"%Y.%m.%d %H:%M:%S"`
	echo "configuring /etc/sudoers.d/espeo file"
	echo "# Espeo Software custom sudoers list, last generated at $dt
%espeodev ALL=(root) NOPASSWD: /opt/farm/ext/cloud-client-ec2/utils/setup-account.sh
" >/etc/sudoers.d/espeo
fi
