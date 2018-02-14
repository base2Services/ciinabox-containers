# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node.
FROM base2/amazon-ecr-credential-helper:latest as amazon-ecr-credential-helper

FROM java:openjdk-8-jdk
MAINTAINER "base2Services" <itsupport@base2services.com>

# Default to not using credentials helper and docker 17.03.2-ce
ARG USE_ECR_CREDENTIAL_HELPER="0"
ARG DOCKER_VERSION="17.03.2-ce"
ARG DOCKER_STORAGE_DRIVER="vfs"
ENV USE_ECR_CREDENTIAL_HELPER $USE_ECR_CREDENTIAL_HELPER
ENV DOCKER_VERSION $DOCKER_VERSION

ENV DEBIAN_FRONTEND noninteractive

ENV CHEFDK_VERSION "2.4.17"
ENV PACKER_VERSION "1.1.3"
ENV DOCKER_STORAGE_DRIVER $DOCKER_IN_DOCKER_STORAGE_DRIVER

# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
  apt-transport-https \
  gettext-base \
  ca-certificates \
  lxc \
  iptables \
  git \
  git-core \
  git-flow \
  python-pip \
  unzip \
  jq \
  openssh-server \
  sudo \
  groff \
  less \
  zip \
  && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
  && sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd \
  && mkdir -p /var/run/sshd \
  && adduser --quiet jenkins && echo "jenkins:jenkins" | chpasswd \
  && echo "jenkins ALL = NOPASSWD: ALL" > /etc/sudoers.d/jenkins \
  && usermod -a -G root jenkins \
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

# Install and configure amazon-ecr-credentials helper
COPY --from=amazon-ecr-credential-helper /bin/docker-credential-ecr-login /bin/docker-credential-ecr-login
COPY setup_ecr_credentials_helper.sh /bin/setup_ecr_credentials_helper
COPY jenkins-docker-slave.sh  /usr/local/bin/jenkins-docker-slave.sh
RUN chmod a+x /bin/setup_ecr_credentials_helper; \
    chmod a+x /usr/local/bin/jenkins-docker-slave.sh

EXPOSE 22

ENV TINI_VERSION v0.15.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD ["/usr/local/bin/jenkins-docker-slave.sh"]
