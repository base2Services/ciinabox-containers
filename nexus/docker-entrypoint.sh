#!/bin/bash

#ensure we have correct permissions
sudo chown -R $SONATYPE_WORK

$@
