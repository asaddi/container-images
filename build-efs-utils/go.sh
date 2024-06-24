#!/bin/sh

set -e

git clone https://github.com/aws/efs-utils.git
cd efs-utils
git checkout ${EFS_UTILS_VERSION:-master}
./build-deb.sh
ls -l $(realpath ./build)/amazon-efs-utils*.deb
