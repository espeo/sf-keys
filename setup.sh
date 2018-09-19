#!/bin/sh
. /opt/farm/scripts/init


echo "preparing ssh key"
FULLKEY=`/opt/farm/ext/keys/get-ssh-management-key-content.sh $HOST`

if [ ! -f /root/.ssh/authorized_keys ] || ! grep -q "$FULLKEY" /root/.ssh/authorized_keys; then
	echo "setting up root ssh key"
	mkdir -p /root/.ssh
	echo "$FULLKEY" >>/root/.ssh/authorized_keys
fi


/opt/farm/scripts/setup/extension.sh sf-passwd-utils
echo "checking custom system groups"
/opt/farm/ext/passwd-utils/create-group.sh espeodev
/opt/farm/ext/passwd-utils/create-group.sh espeoadm


/opt/farm/scripts/setup/extension.sh sf-mc-black


if [ "$OSVER" = "ubuntu-trusty" ] || [ "$OSVER" = "ubuntu-xenial" ] || [ "$OSVER" = "ubuntu-bionic" ]; then
	dt=`date +"%Y.%m.%d %H:%M:%S"`
	echo "configuring /etc/sudoers.d/espeo file"
	echo "# Espeo Software custom sudoers list, last generated at $dt
%espeodev ALL=(root) NOPASSWD: /opt/farm/ext/cloud-client-ec2/utils/setup-account.sh
" >/etc/sudoers.d/espeo
fi
