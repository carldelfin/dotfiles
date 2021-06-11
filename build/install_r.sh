#!/bin/sh

####################################################################################################
#
# This script installs the latest version of R, along with commonly used and/or required packages
# for optimal Linux performance
#
# https://www.r-project.org/
# https://cran.r-project.org/bin/linux/ubuntu/
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
 
  # import the signing key (by Michael Rutter)
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
  
  # add the R 4.0 repo
  sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
  
  # update
  sudo apt update -qq
  
  # install
  sudo apt install --no-install-recommends -y \
  r-base r-base-dev
 
  # packages required for certain R libraries
  sudo apt install -y \
  libclang-dev libssl-dev libxml2-dev \
  libcurl4-openssl-dev libssl-dev libxt-dev \
  libopenblas-dev liblapack-dev libopencv-dev \
  libcairo2-dev libnode-dev libgdal-dev \
  libudunits2-dev libprotobuf-dev protobuf-compiler \
  libjq-dev libmagick++-dev
}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mR installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
