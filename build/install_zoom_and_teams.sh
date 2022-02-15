#!/bin/sh

#####################################################################################################
#
# This script installs the latest version of Zoom and Teams
# https://zoom.us/
# https://www.microsoft.com/en/microsoft-teams/group-chat-software
#
##################################################################################################### 

set -e
trap 'catch $? $LINENO' EXIT

catch() {
  if [ "$1" != "0" ]; then
    echo -e "\033[1;31mInstallation failed!\033[0m"
    echo -e "\033[1;31mError $1 occurred on $2\033[0m"
  fi
}

simple() {
  if ! command -v zoom &> /dev/null; then
      cd /tmp
      wget https://zoom.us/client/latest/zoom_amd64.deb
      sudo apt install -y ./*.deb
      rm *.deb
      cd
  else
      echo "zoom is already installed"
  fi
  
  if ! command -v teams &> /dev/null; then
      curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
      sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
      sudo apt update
      sudo apt install teams
      cd /tmp
  else
      echo "teams is already installed"
  fi
}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mZoom and Teams installation OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo ""
