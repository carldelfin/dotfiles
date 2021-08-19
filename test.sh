#!/bin/sh

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
  # Upgrade to Debian Sid
  # ------------------------------------------------------------------------------
  
  #echo 'deb http://deb.debian.org/debian/ sid main contrib non-free' >/tmp/sid.list
  #echo 'deb-src http://deb.debian.org/debian/ sid main contrib non-free' >/tmp/sidsrc.list

  #sudo cp /tmp/sid.list /etc/apt/sources.list.d/
  #sudo cp /tmp/sidsrc.list /etc/apt/sources.list.d/
  
  #rm /tmp/sid.list
  #rm /tmp/sidsrc.list
  
  #sudo apt update
  #sudo apt full-upgrade -y
  
  # ------------------------------------------------------------------------------
  # Install required packages
  # ------------------------------------------------------------------------------

  sudo apt install -y \
  xorg x11-xserver-utils \
  bspwm sxhkd picom kitty polybar suckless-tools rofi pass arandr \
  software-properties-common apt-transport-https build-essential \
  ca-certificates dirmngr make cmake gcc libgtk-3-dev apt-listbugs \
  zathura nautilus feh unzip htop syncthing ufw rsync neofetch firefox \
  alsa-utils pulseaudio libavcodec-extra 
}

simple
echo ""
echo -e "\033[1;32mEverything is set up, time to reboot!\033[0m"
echo ""
