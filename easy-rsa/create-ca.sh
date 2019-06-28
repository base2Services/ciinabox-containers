#/bin/sh
set -e

if [[ -z $EASYRSA_REQ_CN ]]; then
  echo "EASYRSA_REQ_CN is not set"
  exit 1
fi

if [[ -z $EASYRSA_CLIENT_CN ]]; then
  echo "EASYRSA_CLIENT_CN is not set"
  exit 1
fi

if [[ -z $EASYRSA_OUTPUT_DIR ]]; then
  EASYRSA_OUTPUT_DIR="output"
fi

easyrsa init-pki
easyrsa build-ca nopass
easyrsa build-server-full server nopass
easyrsa build-client-full ${EASYRSA_CLIENT_CN} nopass

cp pki/ca.crt $EASYRSA_OUTPUT_DIR/
cp pki/issued/server.crt $EASYRSA_OUTPUT_DIR/
cp pki/private/server.key $EASYRSA_OUTPUT_DIR/
cp pki/issued/${EASYRSA_CLIENT_CN}.crt $EASYRSA_OUTPUT_DIR/
cp pki/private/${EASYRSA_CLIENT_CN}.key $EASYRSA_OUTPUT_DIR/

tar czfv ca.tar.gz pki/
cp ca.tar.gz $EASYRSA_OUTPUT_DIR/
