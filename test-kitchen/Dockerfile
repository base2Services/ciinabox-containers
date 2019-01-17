FROM ruby:2.5-alpine3.7
MAINTAINER "base2Services" <itsupport@base2services.com>

RUN apk add --no-cache \
    libstdc++ \
    g++ \
    make \
    shadow \
    bash \

RUN gem install --no-document \
  inspec \
  kitchen-inspec \
  test-kitchen \
  kitchen-ec2 \
  berkshelf \
  rspec-retry

RUN adduser --quiet jenkins && echo "jenkins:jenkins" | chpasswd \
    && echo "jenkins ALL = NOPASSWD: ALL" > /etc/sudoers.d/jenkins \
    && usermod -a -G root jenkins \

CMD ['kitchen']
