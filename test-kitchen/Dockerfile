FROM ruby:2.5
MAINTAINER "base2Services" <itsupport@base2services.com>

RUN gem install inspec kitchen-inspec test-kitchen kitchen-ec2 berkshelf rspec-retry --no-document

RUN apt-get update -qq && apt-get install -qqy \
  sudo \
  && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
  && adduser --quiet jenkins && echo "jenkins:jenkins" | chpasswd \
  && echo "jenkins ALL = NOPASSWD: ALL" > /etc/sudoers.d/jenkins \
  && usermod -a -G root jenkins \
