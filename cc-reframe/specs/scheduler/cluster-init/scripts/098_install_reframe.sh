#!/bin/bash
set -ex

# Determine the OS version
version=`/bin/bash ${CYCLECLOUD_SPEC_PATH}/files/common.sh`

if [ "$version" == "centos-7" ]
then
    yum install -y centos-release-scl-rh
    yum install -y rh-python38-python
    yum install -y rh-python38-python-pip
    export PATH=/opt/rh/rh-python38/root/usr/bin:$PATH
elif [ "$version" == "centos-8" ]
then
    yum install -y python38 python38-pip
fi

yum install -y git jq

# Install reframe
NHC_PATH="/shared/azure_nhc"
mkdir -p $NHC_PATH
cd $NHC_PATH
rm -rf reframe
git clone https://github.com/JonShelley/reframe.git
cd reframe

./bootstrap.sh
