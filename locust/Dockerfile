FROM python:3.6-alpine

ARG LOCUST_VERSION="0.10.0"
ENV LOCUST_VERSION $LOCUST_VERSION

RUN apk --no-cache add \
      --virtual=.build-dep \
      build-base \
      libzmq \
      linux-headers \
      zeromq-dev \
    && pip install --no-cache-dir \
      locustio==${LOCUST_VERSION} \
      awscli \
    && apk del .build-dep \
    && mkdir /locust

COPY docker-entrypoint.sh /

WORKDIR /locust

EXPOSE 8089 5557 5558

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["locust"]
