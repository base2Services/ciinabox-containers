# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM evarga/jenkins-slave
MAINTAINER Aaron Walker <a.walker@base2services.com>

ENV DEBIAN_FRONTEND noninteractive

# Adapted from: https://registry.hub.docker.com/u/jpetazzo/dind/dockerfile/
# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy apt-transport-https ca-certificates git lxc iptables curl bison build-essential zlib1g-dev libssl-dev libxml2-dev git-core python-pip

#install aws cli tools
pip install awscli

RUN echo "jenkins ALL = NOPASSWD: ALL" > /etc/sudoers.d/jenkins

# Install Docker from Docker Inc. repositories.
RUN curl -sSL https://get.docker.com/ubuntu/ | sh

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
