FROM jenkins:2.32.3
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/custom.groovy
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/ref/plugins.txt)
