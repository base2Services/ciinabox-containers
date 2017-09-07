FROM jenkins:2.60.2
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/custom.groovy
RUN /usr/local/bin/install-plugins.sh $(cat /usr/share/jenkins/ref/plugins.txt)

COPY entrypoint.sh /bin/entrypoint.sh

ENTRYPOINT ["/bin/tini","--","/bin/entrypoint.sh"]
