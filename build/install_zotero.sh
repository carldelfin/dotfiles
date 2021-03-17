#!/bin/bash

# ==============================================================================
#
# This script installs the latest version of Zotero
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
  if ! command -v zotero &> /dev/null; then
      KEY=/usr/local/share/keyrings/zotero.key

      if [ -f "$KEY" ]; then
          echo "$KEY already exists"
      else
          wget -q -O zotero.key "https://github.com/retorquere/zotero-deb/releases/download/apt-get/deb.gpg.key"
          if ! file zotero.key | grep -q "PGP public key"; then
              echo "zotero.key does not appear to be a valid PGP key - aborting!"
              exit 1
          else
              sudo mkdir -p /usr/local/share/keyrings/
              sudo mv zotero.key /usr/local/share/keyrings/
              echo "deb [signed-by=/usr/local/share/keyrings/zotero.key] https://github.com/retorquere/zotero-deb/releases/download/apt-get/ ./" | sudo tee -a /etc/apt/sources.list.d/zotero.list
          fi
      fi
      sudo apt update
      sudo apt install -y zotero
  else
      echo "Zotero is already installed"
  fi
}

simple


echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mZotero installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
