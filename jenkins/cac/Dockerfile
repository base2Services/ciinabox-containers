FROM jenkins:lts

COPY entrypoint.sh /bin/entrypoint.sh
COPY s3get.py /usr/bin/s3get.py
ENV CASC_JENKINS_CONFIG="/var/jenkins_home/jenkins.yaml"

ENTRYPOINT ["/bin/tini","--","/bin/entrypoint.sh"]
