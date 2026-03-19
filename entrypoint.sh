#!/bin/bash

if [ ! -z "$USER_ID" ] && [ "$USER_ID" -ne "$(id -u pokyuser)" ]; then
	sudo usermod -u $USER_ID pokyuser
fi
if [ ! -z "$GROUP_ID" ] && [ "$GROUP_ID" -ne "$(id -g pokyuser)" ]; then
	sudo usermod -u $GROUP_ID pokyuser
fi

sudo service ssh start

echo "--- SSH Server Started ---"
echo "You can connect using: ssh -p ${PORT_ACCESS} pokyuser@localhost"

exec "$@"