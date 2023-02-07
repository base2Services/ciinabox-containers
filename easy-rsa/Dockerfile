FROM debian:bookworm-slim

RUN apt-get update -qq \
    && apt-get install -qqy \
        easy-rsa \
        git \
    && ln -s /usr/share/easy-rsa/easyrsa  /usr/bin/ \
    && mkdir /easy-rsa

ENV EASYRSA=/usr/share/easy-rsa
ENV EASYRSA_PKI=/easy-rsa/pki
ENV EASYRSA_BATCH=yes

WORKDIR /easy-rsa

COPY create-ca.sh /usr/local/bin/create-ca
COPY create-client.sh /usr/local/bin/create-client
COPY revoke-client.sh /usr/local/bin/revoke-client
COPY renew.sh /usr/local/bin/renew
COPY rebuild.sh /usr/local/bin/rebuild

CMD create-ca
