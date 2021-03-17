#!/bin/bash

#####################################################################################################
#
# This script installs some of my most used R packages
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

  Rscript -e 'dir.create(Sys.getenv("R_LIBS_USER"), recursive = TRUE)'
  Rscript -e '.libPaths(Sys.getenv("R_LIBS_USER"))'
  Rscript -e 'install.packages(c("tidyverse", "tidybayes", "brms", "caret", "psych", "emmeans"))'

}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mR packages installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
