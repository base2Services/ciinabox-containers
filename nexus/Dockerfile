FROM sonatype/nexus:oss

ADD docker-entrypoint.sh /usr/local/bin

#fix data permissions
USER root
RUN echo "nexus ALL = NOPASSWD: ALL" > /etc/sudoers.d/nexus
USER nexus

ENTRYPOINT "/usr/local/bin/docker-entrypoint.sh"
