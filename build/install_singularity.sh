#!/bin/sh

#####################################################################################################
#
# This script installs Singularity from source, which includes installing quite a few dependencies
# along with Go.
#
# https://sylabs.io/guides/3.7/user-guide/quick_start.html#quick-installation-steps
# https://golang.org/doc/install
#
####################################################################################################

set -e
trap 'catch $? $LINENO' EXIT

catch() {
  if [ "$1" != "0" ]; then
    echo -e "\033[1;31mInstallation failed!\033[0m"
    echo -e "\033[1;31mError $1 occurred on $2\033[0m"
  fi
}

# NOTE:
# needs to be updated manually
export SINGULARITY_VERSION=3.11.0

simple() {

    # build dependencies
    sudo apt-get install -y \
       wget \
       build-essential \
       libseccomp-dev \
       libglib2.0-dev \
       pkg-config \
       squashfs-tools \
       cryptsetup \
       runc

    # check if Singularity is installed, install if not
    if singularity version | grep -q $SINGULARITY_VERSION; then
        echo "Singularity is already installed"
    else
        wget https://github.com/hpcng/singularity/releases/download/v${SINGULARITY_VERSION}/singularity-${SINGULARITY_VERSION}.tar.gz && \
        tar -xzf singularity-${SINGULARITY_VERSION}.tar.gz && \
        cd singularity
        ./mconfig && make -C builddir && sudo make -C builddir install
        rm singularity-${SINGULARITY_VERSION}.tar.gz
        cd
    fi

}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mSingularity installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
