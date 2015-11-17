FROM alpine:3.2

MAINTAINER Aaron Walker <a.walker@base2services.com>

ADD app/ /app

RUN mkdir -p /data \
    && chmod -R 777 /data
    && mkdir -p /usr/share/nginx \
    && ln -s /app/www /usr/share/nginx/html

VOLUME ["/app", "/data", "/usr/share/nginx/html"]

CMD ["echo", "creating ciinabox data container"]
