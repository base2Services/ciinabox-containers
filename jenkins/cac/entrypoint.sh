#!/bin/bash -xe

if [[ -z "${SRCTAR}" ]]; then
    echo "No source tar provided. Deployment is probably incomplete"
elif [[ "${SRCTAR}" =~ ^s3:.* ]]; then
    echo "Downloading ${SRCTAR} from s3"
    /usr/bin/s3get.py "${SRCTAR}" | tar -vx -C /
elif [[ "${SRCTAR}" =~ ^https?:.* ]]; then
    echo "Downloading ${SRCTAR} from web"
    curl "${SRCTAR}" | tar -vx -C /
elif [[ "${SRCTAR}" =~ ^file:.* ]]; then
    echo "Extracting ${SRCTAR} from file system"
    tar -vxmf `echo "${SRCTAR}" | sed 's:^file\://\?::'` -C /
else
    echo "I don't know how to handle: ${SRCTAR}"
fi

if test -d /inits/; then
    for e in /inits/*.sh; do
        chmod +x "$e" && "$e" || /bin/true
    done
fi

export JAVA_OPTS="-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"

exec /usr/local/bin/jenkins.sh
