#!/bin/bash

# If init file exists, needs to be overwritten
# as jenkins exntrypoint does not handle this situation
# (does not care if init script is updated on)
if [ -f "/var/jenkins_home/init.groovy.d/custom.groovy" ];then
  echo "Updating Jenkins init script in /usr/share/jenkins/ref/init.groovy.d/custom.groovy ..."
  cp /usr/share/jenkins/ref/init.groovy.d/custom.groovy /var/jenkins_home/init.groovy.d/custom.groovy
fi

/usr/local/bin/jenkins.sh
