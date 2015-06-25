#!/bin/bash

set -ex

# start the docker daemon
[ ! -z ${1} ] && /usr/local/bin/wrapdocker &

# start the ssh daemon
/usr/sbin/sshd -D
