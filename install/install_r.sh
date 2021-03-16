#!/bin/bash

# ==============================================================================
#
# This script installs the latest versions of R and Radian,
# as well as some useful packages for optimal R performance
#
# https://www.r-project.org/
# https://github.com/randy3k/radian
#
# ==============================================================================

set -e
trap 'catch $? $LINENO' EXIT

catch() {
  if [ "$1" != "0" ]; then
    echo -e "\033[1;31mInstallation failed!\033[0m"
    echo -e "\033[1;31mError $1 occurred on $2\033[0m"
  fi
}

simple() {
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
  sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu groovy-cran40/'
  sudo apt update
  
  sudo apt install -y \
  r-base r-base-dev \
  libclang-dev libssl-dev \
  libcurl4-openssl-dev libxt-dev \
  libopenblas-dev liblapack-dev libopencv-dev \
  libcairo2-dev libnode-dev
  
  pip install -U radian
  
}

simple
echo -e "\033[1;32mInstallation OK\033[0m"
