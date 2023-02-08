#/bin/bash
set -e

if [ -z $EASYRSA_REQ_CN ]; then
  echo "EASYRSA_REQ_CN is not set"
  exit 1
fi

if [ -z $EASYRSA_CLIENT_CN ]; then
  echo "EASYRSA_CLIENT_CN is not set"
  exit 1
fi

if [ -z $EASYRSA_OUTPUT_DIR ]; then
  EASYRSA_OUTPUT_DIR="output"
fi

OPTS=""
if [ -n $EASYRSA_OPTS ]; then
    OPTS=$EASYRSA_OPTS
fi

tar xzfv output/ca.tar.gz

easyrsa ${OPTS} renew server nopass
easyrsa ${OPTS} renew ${EASYRSA_CLIENT_CN} nopass

cp pki/ca.crt $EASYRSA_OUTPUT_DIR/
cp pki/issued/server.crt $EASYRSA_OUTPUT_DIR/
cp pki/private/server.key $EASYRSA_OUTPUT_DIR/
cp pki/issued/${EASYRSA_CLIENT_CN}.crt $EASYRSA_OUTPUT_DIR/
cp pki/private/${EASYRSA_CLIENT_CN}.key $EASYRSA_OUTPUT_DIR/

tar czfv ca.tar.gz pki/
cp ca.tar.gz $EASYRSA_OUTPUT_DIR/