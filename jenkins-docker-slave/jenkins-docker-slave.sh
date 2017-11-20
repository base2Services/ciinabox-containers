#!/bin/bash -x
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
      echo "Initially group_id = $docker_gid"
      # group exists remove (could be the case when running dood from mac)
      if [[ ! "$docker_gid" =~ ^-?[0-9]+$ ]]; then
        echo "Removing group $docker_gid"
        groupdel $docker_gid
        docker_gid=$(ls -ln /var/run/docker.sock | awk '{print $4}')
        echo "Docker group_id=$docker_gid after removal"
      fi

      groupadd -g $docker_gid docker
      usermod -a -G docker jenkins
      echo "Added group docker with id $docker_gid and added jenkins user to it"

    fi
    if [ -d "/data/jenkins-dood" ]; then
      chown 1000:1000 /data/jenkins-dood
      usermod -d /data/jenkins-dood jenkins
    fi
    # jenkins home folder has been changed so 'setup_ecr_crednetials_helper'
    # needs to re-run
    setup_ecr_credentials_helper
    /usr/sbin/sshd -D
fi
