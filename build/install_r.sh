#!/bin/bash

####################################################################################################
#
# This script installs the latest version of R, along with commonly used and/or required packages
# for optimal Linux performance
#
# https://www.r-project.org/
# https://cran.r-project.org/bin/linux/debian/
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

  # import proper key 
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key '95C0FAF38DB3CCAD0C080A7BDC78B2DDEABC47B7'
  
  # add repository
  echo "deb http://cloud.r-project.org/bin/linux/debian bookworm-cran40/" | sudo tee -a /etc/apt/sources.list
 
  # install
  sudo apt update && sudo apt install -y \
  r-base r-base-dev
 
  # packages required for certain R libraries
  sudo apt install -y \
  libclang-dev libssl-dev libxml2-dev \
  libcurl4-openssl-dev libssl-dev libxt-dev \
  libopenblas-dev liblapack-dev libopencv-dev \
  libcairo2-dev libnode-dev libgdal-dev \
  libudunits2-dev libprotobuf-dev protobuf-compiler \
  libjq-dev libmagick++-dev libharfbuzz-dev libfribidi-dev
  
  # package management
  Rscript -e 'dir.create(Sys.getenv("R_LIBS_USER"), recursive = TRUE)'
  Rscript -e '.libPaths(Sys.getenv("R_LIBS_USER"))'

  # symlink .Rprofile
  ln -s -f $HOME/dotfiles/config/.Rprofile ~/.Rprofile
  
  # install language server
  Rscript -e 'install.packages("remotes")'
  Rscript -e 'remotes::install_github("REditorSupport/languageserver")'
  
  # install commonly used packages
  Rscript -e 'install.packages("rstan", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))'
  Rscript -e 'install.packages(c("brms", "tidyverse", "devtools", "emmeans", "digest","XML", "DT", "knitr", "here", "httr"))'
  Rscript -e 'devtools::install_github("thomasp85/patchwork")'

}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mR installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
