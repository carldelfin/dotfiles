#!/bin/bash

####################################################################################################
#
# This script installs the latest version of R and Radian
# https://www.r-project.org/
# https://github.com/randy3k/radian
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
  
  if ! command -v radian &> /dev/null; then
      sudo apt install -y python3-pip
      pip3 install -U radian
      ln -s -f ~/dotfiles/config/.radian_profile ~/.radian_profile
  else
      echo "Radian is already installed"
  fi

}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mR and Radian installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
