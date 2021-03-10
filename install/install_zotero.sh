#!/bin/bash

# ==============================================================================
#
# This script installs the latest version of Zotero
#
# https://www.zotero.org/
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
  wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
  sudo apt update
  sudo apt install -y zotero
}

simple
echo -e "\033[1;32mInstallation OK\033[0m"