#!/bin/sh

#####################################################################################################
#
# This script installs the latest version of QMK
# https://docs.qmk.fm/
#
##################################################################################################### 

set -e
trap 'catch $? $LINENO' EXIT

catch() {
  if [ "$1" != "0" ]; then
    echo -e "\033[1;31mInstallation failed!\033[0m"
    echo -e "\033[1;31mError $1 occurred on $2\033[0m"
  fi
}

simple() {
  if ! command -v qmk &> /dev/null; then
      sudo apt install -y pipx
      pipx install qmk
      qmk setup
  else
      echo "QMK is already installed"
  fi
}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mQMK installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
