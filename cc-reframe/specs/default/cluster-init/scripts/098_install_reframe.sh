#!/bin/bash
set -ex

# Install reframe
cd /usr/local
yum install -y git 
yum install -y centos-release-scl-rh
yum install -y rh-python38-python
yum install -y rh-python38-python-pip

rm -rf reframe
git clone https://github.com/JonShelley/reframe.git
cd reframe

export PATH=/opt/rh/rh-python38/root/usr/bin:$PATH
./bootstrap.sh
