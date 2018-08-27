FROM jenkins:2.60.3

USER root
RUN touch /jenkins.yaml && chown jenkins:jenkins /jenkins.yaml
USER jenkins
COPY entrypoint.sh /bin/entrypoint.sh
COPY s3get.py /usr/bin/s3get.py
ENV CASC_JENKINS_CONFIG="/jenkins.yaml"

ENTRYPOINT ["/bin/tini","--","/bin/entrypoint.sh"]
