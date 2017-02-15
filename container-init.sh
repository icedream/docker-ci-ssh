#!/bin/sh -e

mkdir -p ~root/.ssh
chmod 700 ~root/.ssh

if [ -f "/authorized_keys" ]; then
	# use mounted-in authorized_keys
	cp -v /authorized_keys ~root/.ssh/authorized_keys
	chmod 600 ~root/.ssh/authorized_keys
elif [ ! -z "$1" ]; then
	# download authorized_keys from http server
	wget -q -O ~root/.ssh/authorized_keys "$1"
	chmod 600 ~root/.ssh/authorized_keys
	shift 1
fi

# generate host keys if they don't exist yet
ssh-keygen -A

# start ssh server
exec "$(which sshd)" -D -e -p 22 "$@"
