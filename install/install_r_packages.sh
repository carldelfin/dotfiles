#!/bin/bash

# ==============================================================================
#
# This script installs my go-to R packages and some required programs
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
 Rscript -e 'install.packages(c("tidyverse", "tidybayes", "brms", "caret", "psych"), repos="https://cloud.r-project.org")'
}

simple
echo -e "\033[1;32mInstallation OK\033[0m"


