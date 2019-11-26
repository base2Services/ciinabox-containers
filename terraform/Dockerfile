ARG VERSION=latest
FROM hashicorp/terraform:${VERSION} as pkg

FROM alpine

RUN apk add ca-certificates --no-cache && \
    adduser -D -u 1000 jenkins

USER jenkins

COPY --from=pkg --chown=jenkins:jenkins /bin/terraform /bin/terraform