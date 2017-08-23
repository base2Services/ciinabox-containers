#!/bin/bash
set -e

setup_ecr_credentials_helper

if [ "$RUN_DOCKER_IN_DOCKER" == "1" ]; then
    /usr/sbin/sshd -D &

    /bin/dockerd \
        --host=unix:///var/run/docker.sock \
        --storage-driver=vfs \
        "$@"
else
    chown 1000:1000 /var/run/docker.sock
    chown 1000:1000 /data/jenkins-dood
    usermod -d /data/jenkins-dood jenkins
    /usr/sbin/sshd -D
fi
