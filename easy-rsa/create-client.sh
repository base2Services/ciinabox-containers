#/bin/sh
set -e

if [[ -z $EASYRSA_CLIENT_CN ]]; then
  echo "EASYRSA_CLIENT_CN is not set"
  exit 1
fi

if [[ -z $EASYRSA_OUTPUT_DIR ]]; then
  EASYRSA_OUTPUT_DIR="output"
fi

tar xzfv output/ca.tar.gz

easyrsa build-client-full ${EASYRSA_CLIENT_CN} nopass

tar czfv ${EASYRSA_CLIENT_CN}.tar.gz pki/issued/${EASYRSA_CLIENT_CN}.crt pki/private/${EASYRSA_CLIENT_CN}.key
cp ${EASYRSA_CLIENT_CN}.tar.gz $EASYRSA_OUTPUT_DIR/
