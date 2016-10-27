# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM evarga/jenkins-slave
MAINTAINER Aaron Walker <a.walker@base2services.com>

ENV DEBIAN_FRONTEND noninteractive

# Adapted from: https://registry.hub.docker.com/u/jpetazzo/dind/dockerfile/
# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy apt-transport-https ca-certificates git lxc iptables curl bison build-essential zlib1g-dev libssl-dev libxml2-dev git-core git-flow python-pip npm unzip

# Install git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y --no-install-recommends git-lfs && \
    git lfs install

RUN curl -L https://opscode-omnibus-packages.s3.amazonaws.com/debian/6/x86_64/chefdk_0.10.0-1_amd64.deb > /tmp/chefdk_0.10.0-1_amd64.deb  && \
  dpkg -i /tmp/chefdk_0.10.0-1_amd64.deb && \
  export LC_CTYPE=en_US.UTF-8 && \
  locale-gen en_US.UTF-8 && \
  curl -L https://releases.hashicorp.com/packer/0.10.1/packer_0.10.1_linux_amd64.zip > /tmp/packer.zip && \
  unzip -o /tmp/packer.zip -d /opt/packer && \
  pip install awscli && \
  ln -s /usr/bin/nodejs /usr/bin/node && \
  npm install -g azure-cli && \
  echo "jenkins ALL = NOPASSWD: ALL" > /etc/sudoers.d/jenkins && \
  curl -sSL https://get.docker.com/ | sh

ADD wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker
VOLUME /var/lib/docker

RUN usermod -a -G docker jenkins

USER jenkins

#Install RVM
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -sSL https://get.rvm.io | bash -s stable --ruby

USER root

VOLUME /home/jenkins

# Standard SSH port
EXPOSE 22

# place the jenkins slave startup script into the container
ADD jenkins-slave-startup.sh /
ENTRYPOINT ["/jenkins-slave-startup.sh"]
