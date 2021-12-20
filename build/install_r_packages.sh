#!/bin/sh

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
  Rscript -e 'install.packages(c("tidyverse", "tidybayes", "brms", "caret", "psych", "emmeans",
                                 "pander", "rmarkdown", "blogdown", "devtools", "here", "reshape2", "patchwork",
                                 "RColorBrewer", "janitor", "data.table", "kableExtra", "performance",
                                 "officer", "flextable", "bayesplot", "haven", "lavaan", "blavaan", "viridis",
                                 "lintr", "GPArotation", "vroom", "ggseg", "xaringan", "xaringanthemer", "blogdown"))'
  Rscript -e 'devtools::install_git("https://github.com/JanMarvin/readspss.git")'
  Rscript -e 'devtools::install_git("https://github.com/gadenbuie/xaringanExtra.git")'
  Rscript -e 'options(repos = c(ggseg = "https://ggseg.r-universe.dev", CRAN = "https://cloud.r-project.org")); install.packages("ggsegExtra")'
}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mR package installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
