#!/bin/bash -xe

if [[ -z "${SRCTAR}" ]]; then
    echo "No source tar provided. Deployment is probably incomplete"
elif [[ "${SRCTAR}" =~ ^s3:.* ]]; then
    echo "Downloading ${SRCTAR} from s3"
    /usr/bin/s3get.py "${SRCTAR}" | tar -vxf -C /
elif [[ "${SRCTAR}" =~ ^https?:.* ]]; then
    echo "Downloading ${SRCTAR} from web"
    curl "${SRCTAR}" | tar -vxf -C /
else
    echo "I don't know how to handle: ${SRCTAR}"
fi

# If init file exists, needs to be overwritten
# as jenkins exntrypoint does not handle this situation
# (does not care if init script is updated on)
if [ -f "/var/jenkins_home/init.groovy.d/custom.groovy" ];then
  echo "Updating Jenkins init script in /usr/share/jenkins/ref/init.groovy.d/custom.groovy ..."
  cp /usr/share/jenkins/ref/init.groovy.d/custom.groovy /var/jenkins_home/init.groovy.d/custom.groovy
fi

/usr/local/bin/jenkins.sh
