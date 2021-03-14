#!/bin/bash

# ==============================================================================
#
# This script installs the latest version of R and RStudio
#
# https://www.r-project.org/
# https://rstudio.com/
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
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
  sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu groovy-cran40/'
  sudo apt update
  
  sudo apt install -y \
  r-base r-base-dev \
  libclang-dev libssl-dev \
  libcurl4-openssl-dev libxt-dev \
  libopenblas-dev liblapack-dev libopencv-dev \
  libcairo2-dev libnode-dev

  cd /tmp
  wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.4.1103-amd64.deb
  sudo apt install -y ./*.deb
  rm *.deb
  cd
  
  mkdir -p ~/.config/RStudio
  ln -s -f ~/dotfiles/config/RStudio/desktop.ini ~/.config/RStudio/desktop.ini
 }

simple
echo -e "\033[1;32mInstallation OK\033[0m"
