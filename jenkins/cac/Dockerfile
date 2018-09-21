FROM jenkins/jenkins:lts

COPY entrypoint.sh /bin/entrypoint.sh
COPY s3get.py /usr/bin/s3get.py
ENV CASC_JENKINS_CONFIG="/var/jenkins_home/jenkins.yaml"
RUN /usr/local/bin/install-plugins.sh jdk-tool command-launcher script-security configuration-as-code configuration-as-code-support
USER root
RUN mkdir /inits/ && chown jenkins:jenkins /inits/
USER $USER
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

ENTRYPOINT ["/sbin/tini","--","/bin/entrypoint.sh"]
