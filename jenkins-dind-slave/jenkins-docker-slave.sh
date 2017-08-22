#!/bin/sh
set -e

setup_ecr_credentials_helper

/usr/sbin/sshd -D &

/bin/dockerd \
	--host=unix:///var/run/docker.sock \
	--storage-driver=vfs \
	"$@"
