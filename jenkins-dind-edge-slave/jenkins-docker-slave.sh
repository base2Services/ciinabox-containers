#!/bin/sh
set -e

/usr/sbin/sshd -D &

dockerd --storage-driver=vfs --host=unix:///var/run/docker.sock "$@" 
