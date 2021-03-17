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
  inkscape neofetch htop texlive texlive-latex-extra \
  qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
  
  sudo adduser `id -un` libvirt
  sudo adduser `id -un` kvm
  
  # r
  #sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
  #sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu groovy-cran40/'
  
  KEY=/usr/local/share/keyrings/marutter.key

  if [ -f "$KEY" ]; then
      echo "$KEY already exists"
  else
      curl -s 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xe298a3a825c0d65dfd57cbb651716619e084dab9' -o marutter.key
      if ! file marutter.key | grep -q "PGP public key"; then
        echo "$KEY does not appear to be a valid PGP key - aborting!"
        exit 1
      else
        sudo mkdir -p /usr/local/share/keyrings/
        sudo mv marutter.key /usr/local/share/keyrings/
        echo "deb [signed-by=/usr/local/share/keyrings/marutter.key.gpg] https://cloud.r-project.org/bin/linux/ubuntu groovy-cran40/" | sudo tee -a /etc/apt/sources.list
      fi
  fi

  sudo apt update
  
  sudo apt install -y \
  r-base r-base-dev \
  libclang-dev libssl-dev \
  libcurl4-openssl-dev libxt-dev \
  libopenblas-dev liblapack-dev libopencv-dev \
  libcairo2-dev libnode-dev
  
  # radian
  if ! command -v radian &> /dev/null; then
    sudo apt install -y python3-pip
    pip install -U radian
    ln -s -f ~/dotfiles/config/.radian_profile ~/.radian_profile
  else
      echo "radian is already installed"
  fi

  # signal
  if ! command -v signal-desktop &> /dev/null; then
    wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
    echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
    sudo apt update && sudo apt install -y signal-desktop
  else
      echo "signal is already installed"
  fi
  
  # zoom
  if ! command -v zoom &> /dev/null; then
    cd /tmp
    wget https://zoom.us/client/latest/zoom_amd64.deb
    sudo apt install -y ./*.deb
    rm *.deb
    cd
  else
      echo "zoom is already installed"
  fi
  
  # zotero
  if ! command -v zoom &> /dev/null; then
    wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
    sudo apt update
    sudo apt install -y zotero
  else
    echo "zotero is already installed"
  fi
 
}

simple
echo ""
echo -e "\033[1;32mFull install OK\033[0m"
echo ""
