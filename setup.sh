#!/bin/sh
. /opt/farm/scripts/init

add_root_key() {
	key=`/opt/farm/ext/keys/get-ssh-management-key-content.sh $1`
	/opt/farm/ext/passwd-utils/add-key.sh root inline "$key"
}


add_root_key $HOST

# actual server hostname can differ from configured one
current=`hostname`
if [ "$HOST" != "$current" ]; then
	add_root_key $current
fi


# TODO: detect also Microsoft Azure and Google Cloud (and only these)

# detect Amazon EC2/ECS and install also keys for one of these
if [ -f /etc/image-id ] && grep -q ami-ecs /etc/image-id; then
	add_root_key ecs-null
elif [ -d /sys/class/dmi/id ] && grep -qi amazon /sys/class/dmi/id/* 2>/dev/null; then
	add_root_key .amazonaws.com
fi


echo "checking custom system groups"
/opt/farm/ext/passwd-utils/create-group.sh espeodev
/opt/farm/ext/passwd-utils/create-group.sh espeoadm


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
