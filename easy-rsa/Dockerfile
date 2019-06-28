FROM alpine

RUN apk add --no-cache easy-rsa \
    # Hack until easy-rsa 3.0.7 is released https://github.com/OpenVPN/easy-rsa/issues/261
    && sed -i 's/^RANDFILE\s*=\s\$ENV.*/#&/' /usr/share/easy-rsa/openssl-easyrsa.cnf \
    && ln -s /usr/share/easy-rsa/easyrsa  /usr/bin/ \
    && mkdir /easy-rsa

ENV EASYRSA=/usr/share/easy-rsa
ENV EASYRSA_PKI=/easy-rsa/pki
ENV EASYRSA_BATCH=yes

WORKDIR /easy-rsa

COPY create-ca.sh /usr/local/bin/create-ca
COPY create-client.sh /usr/local/bin/create-client
COPY revoke-client.sh /usr/local/bin/revoke-client

CMD create-ca
