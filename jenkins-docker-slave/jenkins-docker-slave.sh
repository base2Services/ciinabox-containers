#!/bin/bash
set -e

setup_ecr_credentials_helper

if [ -f "/var/run/docker.pid" ];then
  rm /var/run/docker.pid
fi

if [ "$RUN_DOCKER_IN_DOCKER" == "1" ]; then
    /usr/sbin/sshd -D &

    /bin/dockerd \
        --host=unix:///var/run/docker.sock \
        --storage-driver=vfs \
        "$@"
else
    if [ -f "/var/run/docker.sock" ]; then
      chown 1000:1000 /var/run/docker.sock
    fi
    if [ -d "/data/jenkins-dood" ]; then
      chown 1000:1000 /data/jenkins-dood
      usermod -d /data/jenkins-dood jenkins
    fi
    /usr/sbin/sshd -D
fi
