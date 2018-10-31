#!/usr/bin/env bash

if [ "$USE_ECR_CREDENTIAL_HELPER" == "1" ]; then
  cat > /root/docker.config.ecr.json << EOF
  {
  	 "credsStore": "ecr-login"
  }
EOF
  mkdir /root/.docker
  jenkins_home=$(cat /etc/passwd | grep jenkins | cut -d: -f6)
  mkdir -p $jenkins_home/.docker
  cp /root/docker.config.ecr.json /root/.docker/config.json
  cp /root/docker.config.ecr.json $jenkins_home/.docker/config.json
  chown -R 1000:1000 $jenkins_home/.docker
  rm /root/docker.config.ecr.json
fi
