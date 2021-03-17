#!/bin/bash

# ==============================================================================
#
# This script installs the latest version of R and Radian
# https://www.r-project.org/
# https://github.com/randy3k/radian
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

  Rscript -e 'install.packages(c("tidyverse", "tidybayes", "brms", "caret", "psych", "emmeans"), repos="https://cloud.r-project.org")'

}

simple
echo -e "\033[1;32mR package installation OK\033[0m"
