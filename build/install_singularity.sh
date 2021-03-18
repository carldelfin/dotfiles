#!/bin/bash

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

export SINGULARITY_VERSION=3.7.0
export GO_VERSION=1.16.2

simple() {

    # build dependencies
    sudo apt install -y \
    build-essential libssl-dev uuid-dev libgpgme11-dev squashfs-tools libseccomp-dev pkg-config cryptsetup

    # check if Go is installed, install if not
    if go version | grep -q $GO_VERSION; then
        echo "Go is already installed"
    else
        cd /tmp
        wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
        sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
        echo "export PATH=/usr/local/go/bin:$PATH" >> ~/.bashrc && source ~/.bashrc
        rm go${GO_VERSION}.linux-amd64.tar.gz
    fi
    
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
