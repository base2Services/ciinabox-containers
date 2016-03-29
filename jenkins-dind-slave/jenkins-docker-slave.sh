#!/bin/sh
set -e

/usr/sbin/sshd -D &

docker daemon \
	--host=unix:///var/run/docker.sock \
	--storage-driver=vfs \
	"$@"
