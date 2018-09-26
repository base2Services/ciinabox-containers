FROM jenkins/jenkins:lts

COPY entrypoint.sh /bin/entrypoint.sh
COPY s3get.py /usr/bin/s3get.py
COPY install-plugins-local.sh /usr/local/bin/install-plugins-local.sh
ENV CASC_JENKINS_CONFIG="/var/jenkins_home/jenkins.yaml"
RUN /usr/local/bin/install-plugins.sh jdk-tool command-launcher script-security configuration-as-code configuration-as-code-support
USER root
RUN mkdir -p /inits/ && chown jenkins:jenkins /inits/ && chmod a+x /usr/local/bin/install-plugins-local.sh
USER $USER

ENTRYPOINT ["/sbin/tini","--","/bin/entrypoint.sh"]
