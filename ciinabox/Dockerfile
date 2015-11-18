FROM alpine:3.2

MAINTAINER Aaron Walker <a.walker@base2services.com>

ADD app/ /app

RUN mkdir -p /data \
    && mkdir /var/jenkins_home \
    && chown -R 1000:1000 /var/jenkins_home \
    && mkdir -p /usr/share/nginx \
    && ln -s /app/www /usr/share/nginx/html

VOLUME ["/app", "/data", "/usr/share/nginx/html", "/var/jenkins_home"]

CMD ["echo", "creating ciinabox data container"]
