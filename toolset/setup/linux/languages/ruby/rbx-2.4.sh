#!/bin/bash

fw_depends rvm

RETCODE=$(fw_exists ${IROOT}/rbx-2.4.installed)
[ ! "$RETCODE" == 0 ] || { \
  # Load environment variables
  source $IROOT/rbx-2.4.installed
  return 0; }

# rvm stable [typically] only provides one version of rbx-2.4
# update this when it changes
RBX_VERSION=2.4.1

# This version of RBX needs clang 3.4
sudo apt-get -yq --force-yes install clang-3.4

SHELL="/bin/bash" rvm install rbx-$RBX_VERSION
# Bundler is SOMETIMES missing... not sure why.
SHELL="/bin/bash" rvm rbx-$RBX_VERSION do gem install bundler

echo "export LC_ALL=en_US.UTF-8" > $IROOT/rbx-2.4.installed
echo "export LANG=en_US.UTF-8" >> $IROOT/rbx-2.4.installed
echo "export RBX_VERSION=${RBX_VERSION}" >> $IROOT/rbx-2.4.installed

source $IROOT/rbx-2.4.installed
