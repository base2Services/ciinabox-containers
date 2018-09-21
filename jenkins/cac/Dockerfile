FROM jenkins/jenkins:lts

COPY entrypoint.sh /bin/entrypoint.sh
COPY s3get.py /usr/bin/s3get.py
ENV CASC_JENKINS_CONFIG="/var/jenkins_home/jenkins.yaml"
RUN /usr/local/bin/install-plugins.sh jdk-tool && \
    /usr/local/bin/install-plugins.sh command-launcher && \
    /usr/local/bin/install-plugins.sh script-security && \
    /usr/local/bin/install-plugins.sh configuration-as-code && \
    /usr/local/bin/install-plugins.sh configuration-as-code-support && \
    mkdir /inits/ && chown jenkins:jenkins /inits/

ENTRYPOINT ["/sbin/tini","--","/bin/entrypoint.sh"]
