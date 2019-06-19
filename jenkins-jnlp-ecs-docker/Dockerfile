FROM jenkins/jnlp-slave:3.29-1

MAINTAINER "base2Services" <itsupport@base2services.com>

USER root

# Default to not using credentials helper and docker 17.03.2-ce
ARG DOCKER_VERSION="18.09.6"
ENV DEBIAN_FRONTEND noninteractive
ENV CHEFDK_VERSION "4.0.60"
ENV PACKER_VERSION "1.4.1"

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
  apt-transport-https \
  gettext-base \
  ca-certificates \
  lxc \
  git \
  git-core \
  git-flow \
  python-pip \
  unzip \
  jq \
  groff \
  less \
  zip \
  && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
  && curl "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz" > /tmp/docker.tgz \
  && tar -xf /tmp/docker.tgz -C /tmp && mv /tmp/docker/* /bin && rm -rf /tmp/docker* \
  && curl -kL "https://packages.chef.io/files/stable/chefdk/${CHEFDK_VERSION}/debian/8/chefdk_${CHEFDK_VERSION}-1_amd64.deb" > /tmp/chefdk.deb \
  && dpkg -i /tmp/chefdk.deb \
  && curl -L "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip" > /tmp/packer.zip \
  && unzip -o /tmp/packer.zip -d /opt/packer \
  && pip install awscli

# Install git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get install -y --no-install-recommends git-lfs && \
    git lfs install

USER ${user}
