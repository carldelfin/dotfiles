#!/bin/bash

# ==============================================================================
#
# This script installs the latest Linux kernel
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
  echo deb http://deb.debian.org/debian buster-backports main contrib non-free | sudo tee /etc/apt/sources.list.d/buster-backports.list
  sudo apt update
  sudo apt install -y -t buster-backports linux-image-amd64 firmware-linux firmware-linux-nonfree
}

simple
echo -e "\033[1;32mInstallation OK\033[0m"
