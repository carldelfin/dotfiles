#!/bin/bash

sudo apt-get update && sudo apt-get install -y \
    build-essential \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    wget \
    pkg-config \
    git \
    cryptsetup
    
cd /tmp

wget https://golang.org/dl/go1.16.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.16.2.linux-amd64.tar.gz
echo "export PATH=/usr/local/go/bin:$PATH" >> ~/.bashrc && source ~/.bashrc
go version
rm go1.16.2.linux-amd64.tar.gz

export VERSION=3.7.0 && \
    wget https://github.com/hpcng/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz && \
    tar -xzf singularity-${VERSION}.tar.gz && \
    cd singularity
    
./mconfig && \
    make -C builddir && \
    sudo make -C builddir install
    
rm singularity-${VERSION}.tar.gz
cd
