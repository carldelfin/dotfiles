#!/bin/bash

# ==============================================================================
#
# This script gets my workstation up and running after a clean install,
# INCLUDING setting up UFW.
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
  # Install required packages
  # ------------------------------------------------------------------------------

  sudo apt install -y \
  bspwm kitty polybar suckless-tools rofi pass \
  apt-transport-https lxappearance \
  zathura ranger feh htop syncthing neofetch

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
  
  # mullvad
  cd /tmp
  wget https://mullvad.net/media/app/MullvadVPN-2020.7_amd64.deb
  sudo apt install -y ./*.deb
  rm *.deb
  cd

  # signal
  wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
  echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list
  sudo apt update && sudo apt install -y signal-desktop
  
  # r and rstudio
  sudo apt install -y \
  libclang-dev libssl-dev \
  libcurl4-openssl-dev libxt-dev \
  libopenblas-dev liblapack-dev libopencv-dev \
  libcairo2-dev libnode-dev
  
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
  sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu groovy-cran40/'
  sudo apt update
  sudo apt install -y r-base r-base-dev

  cd /tmp
  wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.4.1103-amd64.deb
  sudo apt install -y ./*.deb
  rm *.deb
  cd
  
  # zotero
  wget -qO- https://github.com/retorquere/zotero-deb/releases/download/apt-get/install.sh | sudo bash
  sudo apt update
  sudo apt install -y zotero

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
  chmod +x ~/dotfiles/scripts/launch.sh
  chmod +x ~/dotfiles/scripts/vpn.sh
  chmod +x ~/dotfiles/scripts/upgrades.sh
  chmod +x ~/dotfiles/scripts/backup.sh
  chmod +x ~/dotfiles/scripts/weather.R

  # ------------------------------------------------------------------------------
  # Set up symlinks
  # ------------------------------------------------------------------------------
  
  mkdir -p ~/.config/{bspwm,sxhkd,kitty,rofi,rofi-pass,RStudio,ranger,zathura}
  ranger --copy-config=all

  ln -s -f ~/dotfiles/config/.bashrc ~/.bashrc
  ln -s -f ~/dotfiles/config/.xinitrc ~/.xinitrc
  ln -s -f ~/dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
  ln -s -f ~/dotfiles/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
  ln -s -f ~/dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
  ln -s -f ~/dotfiles/config/rofi/my_theme.rasi ~/.config/rofi/my_theme.rasi
  ln -s -f ~/dotfiles/config/RStudio/desktop.ini ~/.config/RStudio/desktop.ini
  ln -s -f ~/dotfiles/config/rofi-pass/config ~/.config/rofi-pass/config
  ln -s -f ~/dotfiles/config/ranger/rifle.conf ~/.config/ranger/rifle.conf
  ln -s -f ~/dotfiles/config/ranger/rc.conf ~/.config/ranger/rc.conf
  ln -s -f ~/dotfiles/config/zathura/zathurarc ~/.config/zathura/zathurarc
 
}

simple
echo ""
echo -e "\033[1;32mEverything is set up, time to reboot!\033[0m"
echo ""
