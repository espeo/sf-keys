#!/bin/sh
. /opt/farm/scripts/init

echo "checking custom system groups"
/opt/farm/ext/passwd-utils/create-group.sh espeodev
/opt/farm/ext/passwd-utils/create-group.sh espeoadm

/opt/farm/ext/keys/setup-root-keys.sh
/opt/farm/ext/keys/setup-custom-sudoers.sh

/opt/farm/scripts/setup/extension.sh sf-mc-black
/opt/farm/scripts/setup/extension.sh sf-db-tools
/opt/farm/scripts/setup/extension.sh sf-app-deploy
/opt/farm/scripts/setup/extension.sh sf-circle
