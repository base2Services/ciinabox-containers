#!/bin/sh
set -e

/usr/sbin/sshd -D &

/bin/dockerd \
	--host=unix:///var/run/docker.sock \
	--storage-driver=vfs \
	"$@"
