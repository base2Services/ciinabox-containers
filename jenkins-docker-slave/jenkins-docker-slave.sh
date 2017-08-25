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
    if [ -S "/var/run/docker.sock" ]; then
      docker_gid=$(ls -la /var/run/docker.sock | awk '{print $4}')
      groupadd -g $docker_gid docker
      usermod -a -G docker jenkins
      echo "Added group docker with id $docker_gid and added jenkins user to it"
    fi
    if [ -d "/data/jenkins-dood" ]; then
      chown 1000:1000 /data/jenkins-dood
      usermod -d /data/jenkins-dood jenkins
    fi
    /usr/sbin/sshd -D
fi
