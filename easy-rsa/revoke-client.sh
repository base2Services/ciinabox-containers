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
tar xzfv output/${EASYRSA_CLIENT_CN}.tar.gz

easyrsa revoke ${EASYRSA_CLIENT_CN}
easyrsa gen-crl

cp pki/crl.pem $EASYRSA_OUTPUT_DIR/
