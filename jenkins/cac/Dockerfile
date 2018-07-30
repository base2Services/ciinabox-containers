FROM jenkins:2.60.3
COPY custom.groovy /usr/share/jenkins/ref/init.groovy.d/custom.groovy
COPY --chown=jenkins:jenkins /configuration-as-code.hpi /var/jenkins_home/plugins_to_install/configuration-as-code.hpi
COPY --chown=jenkins:jenkins /configascode.groovy /var/jenkins_home/init.groovy.d/configascode.groovy

COPY entrypoint.sh /bin/entrypoint.sh

ENV CASC_JENKINS_CONFIG="/jenkins.yaml"

ENTRYPOINT ["/bin/tini","--","/bin/entrypoint.sh"]
