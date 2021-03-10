#!/bin/bash

# ==============================================================================
#
# This script installs texlive (with some extras)
#
# https://www.tug.org/texlive/
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
  sudo apt install -y texlive texlive-latex-extra
}

simple
echo -e "\033[1;32mInstallation OK\033[0m"  
