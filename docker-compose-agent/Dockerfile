FROM java:openjdk-8-jdk
MAINTAINER "base2Services" <itsupport@base2services.com>

ENV DOCKER_VERSION="18.03.1-ce"
ENV DOCKER_COMPOSE_VERSION="1.21.2"

RUN curl "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" > /tmp/docker.tgz \
  && tar -xf /tmp/docker.tgz -C /tmp && mv /tmp/docker/* /usr/local/bin && rm -rf /tmp/docker* \
  && curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
  && chmod a+x /usr/local/bin/docker-compose

RUN apt-get update -qq && apt-get install -qqy \
  sudo \
  && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
  && adduser --quiet jenkins && echo "jenkins:jenkins" | chpasswd \
  && echo "jenkins ALL = NOPASSWD: ALL" > /etc/sudoers.d/jenkins \
  && usermod -a -G root jenkins \
