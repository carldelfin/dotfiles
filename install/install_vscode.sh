#!/bin/bash

# ==============================================================================
#
# This script installs the latest version of Visual Studio Code
#
# https://code.visualstudio.com/
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
  wget https://az764295.vo.msecnd.net/stable/ea3859d4ba2f3e577a159bc91e3074c5d85c0523/code_1.52.1-1608136922_amd64.deb
  sudo apt install -y ./*.deb
  rm *.deb
  cd
}

simple
echo -e "\033[1;32mInstallation OK\033[0m"