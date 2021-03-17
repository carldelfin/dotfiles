#!/bin/bash

# ==============================================================================
#
# This script gets my workstation up and running after a clean install.
#
# Do not use this script blindly, it might not do what you want! 
# Make sure to read through this file and make changes accordingly.
#
# ==============================================================================

# ------------------------------------------------------------------------------
# Define a try catch function
# Based on: https://medium.com/@dirk.avery/the-bash-trap-trap-ce6083f36700
# ------------------------------------------------------------------------------

set -e
trap 'catch $? $LINENO' EXIT

catch() {
  if [ "$1" != "0" ]; then
    echo -e "\033[1;31mInstallation failed!\033[0m"
    echo -e "\033[1;31mError $1 occurred on $2\033[0m"
  fi
}

simple() {

  # ------------------------------------------------------------------------------
  # Install required packages
  # ------------------------------------------------------------------------------

  sudo apt install -y \
  inkscape neofetch htop texlive texlive-latex-extra
  
  # kvm
  sudo apt install -y \
  qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
  sudo adduser `id -un` libvirt
  sudo adduser `id -un` kvm
  
  # r
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
  sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu groovy-cran40/'
  sudo apt update
  
  sudo apt install -y \
  r-base r-base-dev \
  libclang-dev libssl-dev \
  libcurl4-openssl-dev libxt-dev \
  libopenblas-dev liblapack-dev libopencv-dev \
  libcairo2-dev libnode-dev
  
  # radian
  sudo apt install -y python3-pip
  pip install -U radian
  
  # signal
  wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
  echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
  sudo apt update && sudo apt install -y signal-desktop
  
  # zoom
  cd /tmp
  wget https://zoom.us/client/latest/zoom_amd64.deb
  sudo apt install -y ./*.deb
  rm *.deb
  cd
  
  # zotero
  wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
  sudo apt update
  sudo apt install -y zotero
 
}

simple
echo ""
echo -e "\033[1;32mSystem setup OK!\033[0m"
echo ""
