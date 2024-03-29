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

easyrsa init-pki
easyrsa build-ca nopass
easyrsa ${OPTS} build-server-full server nopass
easyrsa ${OPTS} build-client-full ${EASYRSA_CLIENT_CN} nopass

echo "copying pki/ca.crt to $EASYRSA_OUTPUT_DIR/"
cp pki/ca.crt $EASYRSA_OUTPUT_DIR/
echo "copying pki/issued/server.crt to $EASYRSA_OUTPUT_DIR/"
cp pki/issued/server.crt $EASYRSA_OUTPUT_DIR/
echo "copying pki/private/server.key to $EASYRSA_OUTPUT_DIR/"
cp pki/private/server.key $EASYRSA_OUTPUT_DIR/
echo "copying pki/issued/${EASYRSA_CLIENT_CN}.crt to $EASYRSA_OUTPUT_DIR/"
cp pki/issued/${EASYRSA_CLIENT_CN}.crt $EASYRSA_OUTPUT_DIR/
echo "pki/private/${EASYRSA_CLIENT_CN}.key to $EASYRSA_OUTPUT_DIR/"
cp pki/private/${EASYRSA_CLIENT_CN}.key $EASYRSA_OUTPUT_DIR/

tar czfv ca.tar.gz pki/

echo "ca.tar.gz to $EASYRSA_OUTPUT_DIR/"
cp ca.tar.gz $EASYRSA_OUTPUT_DIR/
