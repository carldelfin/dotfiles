#!/bin/sh

####################################################################################################
#
# This script installs the latest version of TexLive and Pandoc, including support for XeLaTex
#
# https://www.tug.org/texlive/
# https://pandoc.org/
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
  sudo apt install -y texlive texlive-latex-extra texlive-fonts-extra texlive-xetex pandoc pandoc-citeproc latexmk
  tlmgr init-usertree
  tlmgr install fontspec
  tlgmr install ifsym
}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mTexLive and Pandoc installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
