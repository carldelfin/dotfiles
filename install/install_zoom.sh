#!/bin/bash

# ==============================================================================
#
# This script installs the latest version of Zoom
#
# https://zoom.us/
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
  cd /tmp
  wget https://zoom.us/client/latest/zoom_amd64.deb
  sudo apt install -y ./*.deb
  rm *.deb
  cd
}

simple
echo -e "\033[1;32mInstallation OK\033[0m"
  