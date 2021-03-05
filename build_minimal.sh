#!/bin/bash

# ==============================================================================
#
# This script gets my workstation up and running after a clean install,
# INCLUDING setting up UFW and adding a cron job.
#
# This might not be what you want! Make sure to read through this file and make
# changes accordingly!
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
  # Upgrade to Debian Sid
  # ------------------------------------------------------------------------------
  
  echo 'deb http://deb.debian.org/debian/ sid main contrib non-free' >/tmp/sid.list
  echo 'deb-src http://deb.debian.org/debian/ sid main contrib non-free' >/tmp/sidsrc.list

  sudo cp /tmp/sid.list /etc/apt/sources.list.d/
  sudo cp /tmp/sidsrc.list /etc/apt/sources.list.d/
  
  rm /tmp/sid.list
  rm /tmp/sidsrc.list
  
  sudo apt update
  sudo apt full-upgrade -y
  
  # ------------------------------------------------------------------------------
  # Install required packages
  # ------------------------------------------------------------------------------

  sudo apt install -y \
  
  # main
  xorg x11-xserver-utils bspwm sxhkd kitty polybar suckless-tools rofi pass \
  software-properties-common apt-transport-https build-essential \
  ca-certificates dirmngr make cmake \
  
  # utils
  zathura ranger nautilus feh unzip htop syncthing ufw rsync neofetch \
  
  # media
  alsa-utils pulseaudio libavcodec-extra \

  # passmenu
  sudo cp /usr/share/doc/pass/examples/dmenu/passmenu /usr/bin/passmenu
  sudo chmod +x /usr/bin/passmenu
  
  # rofi-pass
  cd /tmp
  wget https://github.com/carnager/rofi-pass/archive/master.zip
  unzip master.zip
  rm master.zip
  cd rofi-pass-master
  sudo make
  mkdir -p ~/.config/rofi-pass
  mv config.example ~/.config/rofi-pass/config
  cd ..
  sudo rm -rf rofi-pass-master
  cd
  
  # rofi-power-menu
  cd /tmp
  wget https://raw.githubusercontent.com/jluttine/rofi-power-menu/master/rofi-power-menu
  sudo mv rofi-power-menu /usr/local/bin
  sudo chmod +x /usr/local/bin/rofi-power-menu
  cd

  # ------------------------------------------------------------------------------
  # Fonts 
  # ------------------------------------------------------------------------------
  
  # fira code
  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts
  wget https://github.com/tonsky/FiraCode/releases/download/5.2/Fira_Code_v5.2.zip
  unzip *.zip
  mv ~/.local/share/fonts/ttf/*.ttf ~/.local/share/fonts
  rm *.txt
  rm *.html
  rm *.zip
  rm *.css
  rm -rf woff
  rm -rf woff2
  rm -rf variable_ttf
  rm -rf ttf
  
  # fontawesome
  wget https://use.fontawesome.com/releases/v5.15.2/fontawesome-free-5.15.2-desktop.zip
  unzip *.zip
  mv fontawesome-free-5.15.2-desktop/otfs/*.otf ~/.local/share/fonts/
  rm *.zip
  rm -rf fontawesome-free-5.15.2-desktop
  cd
  
  fc-cache -f -v
  
  # ------------------------------------------------------------------------------
  # Make sure relevant configs and scripts are executable
  # ------------------------------------------------------------------------------
  
  chmod +x ~/dotfiles/config/bspwm/bspwmrc
  chmod +x ~/dotfiles/config/scripts/launch.sh
  chmod +x ~/dotfiles/config/scripts/vpn.sh
  chmod +x ~/dotfiles/config/scripts/upgrades.sh
  chmod +x ~/dotfiles/config/scripts/backup.sh
  chmod +x ~/dotfiles/config/scripts/weather.R

  # ------------------------------------------------------------------------------
  # Set up symlinks
  # ------------------------------------------------------------------------------
  
  mkdir -p ~/.config/{bspwm,sxhkd,kitty,rofi,rofi-pass,ranger,zathura}
  ranger --copy-config=all

  ln -s -f ~/dotfiles/config/.bashrc ~/.bashrc
  ln -s -f ~/dotfiles/config/.xinitrc ~/.xinitrc
  ln -s -f ~/dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
  ln -s -f ~/dotfiles/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
  ln -s -f ~/dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
  ln -s -f ~/dotfiles/config/rofi/my_theme.rasi ~/.config/rofi/my_theme.rasi
  ln -s -f ~/dotfiles/config/rofi-pass/config ~/.config/rofi-pass/config
  ln -s -f ~/dotfiles/config/ranger/rifle.conf ~/.config/ranger/rifle.conf
  ln -s -f ~/dotfiles/config/ranger/rc.conf ~/.config/ranger/rc.conf
  ln -s -f ~/dotfiles/config/zathura/zathurarc ~/.config/zathura/zathurarc
}

simple
echo ""
echo -e "\033[1;32mEverything is set up, time to reboot!\033[0m"
echo ""
