#!/usr/bin/env bash

if [ "$USE_ECR_CREDENTIAL_HELPER" == "1" ]; then
  cat > /root/docker.config.ecr.json << EOF
  {
  	 "credsStore": "ecr-login"
  }
EOF
  mkdir /root/.docker
  mkdir -p home/jenkins/.docker
  cp /root/docker.config.ecr.json /root/.docker/config.json
  cp /root/docker.config.ecr.json /home/jenkins/.docker/config.json
  chown -R 1000:1000 /home/jenkins/.docker
  rm /root/docker.config.ecr.json
fi
