# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM java:openjdk-8-jdk
MAINTAINER Aaron Walker <a.walker@base2services.com>

ENV DEBIAN_FRONTEND noninteractive

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
  apt-transport-https \
  ca-certificates \
  lxc \
  iptables \
  git \
  git-core \
  git-flow \
  python-pip \
  unzip \
  openssh-server \
  sudo \
  groff \
  less \
  && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
  && sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd \
  && mkdir -p /var/run/sshd \
  && adduser --quiet jenkins && echo "jenkins:jenkins" | chpasswd \
  && echo "jenkins ALL = NOPASSWD: ALL" > /etc/sudoers.d/jenkins \
  && usermod -a -G root jenkins \
  && curl -sSL https://get.docker.com/builds/Linux/x86_64/docker-1.9.1 > /usr/bin/docker && chmod +x /usr/bin/docker \
  && curl -kL https://packages.chef.io/stable/debian/6/chefdk_0.12.0-1_amd64.deb > /tmp/chefdk.deb \
  && dpkg -i /tmp/chefdk.deb \
  && curl -sSL https://releases.hashicorp.com/packer/0.9.0/packer_0.9.0_linux_amd64.zip > /tmp/packer.zip \
  && unzip -o /tmp/packer.zip -d /opt/packer \
  && pip install awscli

EXPOSE 22

COPY jenkins-docker-slave.sh /usr/local/bin
ENTRYPOINT ["/usr/local/bin/jenkins-docker-slave.sh"]
CMD []
