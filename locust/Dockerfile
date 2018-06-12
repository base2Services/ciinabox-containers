FROM python:3.6-alpine

COPY docker-entrypoint.sh /

ARG LOCUST_VERSION="0.8.1"
ENV LOCUST_VERSION $LOCUST_VERSION

RUN apk --no-cache add --virtual=.build-dep build-base \
    && apk --no-cache add libzmq \
    && pip install --no-cache-dir locustio==${LOCUST_VERSION} awscli\
    && apk del .build-dep \
    && chmod +x /docker-entrypoint.sh

RUN  mkdir /locust

WORKDIR /locust

EXPOSE 8089 5557 5558

ENTRYPOINT ["/docker-entrypoint.sh"]
