#!/bin/sh

####################################################################################################
#
# This script installs the latest version of R
# https://www.r-project.org/
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

simple() {
  sudo apt install -y \
  r-base r-base-dev \
  libclang-dev libssl-dev libxml2-dev \
  libcurl4-openssl-dev libssl-dev libxt-dev \
  libopenblas-dev liblapack-dev libopencv-dev \
  libcairo2-dev libnode-dev
}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mR installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
