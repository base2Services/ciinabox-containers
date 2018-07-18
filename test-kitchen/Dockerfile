FROM ruby:2.5-alpine3.7
MAINTAINER "base2Services" <itsupport@base2services.com>

RUN apk add --no-cache \
    libstdc++ \
    g++ \
    make \
    shadow \
    bash \
    openjdk8 \
    git \
    openssh-client \
    && adduser -u 1000 -D kitchen

RUN gem install --no-document \
  inspec \
  kitchen-inspec \
  test-kitchen \
  kitchen-ec2 \
  berkshelf \
  rspec-retry

USER kitchen

CMD ['kitchen']
