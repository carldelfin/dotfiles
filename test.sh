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
  python3-pip exfat-fuse exfat-utils
  #xorg x11-xserver-utils \
  #bspwm sxhkd picom kitty polybar suckless-tools rofi pass arandr \
  #software-properties-common apt-transport-https build-essential \
  #ca-certificates dirmngr make cmake gcc libgtk-3-dev apt-listbugs \
  #zathura nautilus feh unzip htop syncthing ufw rsync neofetch firefox \
  #alsa-utils pulseaudio libavcodec-extra \
  
  # passmenu  
  if ! command -v passmenu &> /dev/null; then
      sudo cp /usr/share/doc/pass/examples/dmenu/passmenu /usr/bin/passmenu
      sudo chmod +x /usr/bin/passmenu
  else
      echo "passmenu is already installed"
  fi

  # rofi-pass
  if ! command -v rofi-pass &> /dev/null; then
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
  else
      echo "rofi-pass is already installed"
  fi
  
  # rofi-power-menu
  if ! command -v rofi-power-menu &> /dev/null; then
      cd /tmp
      wget https://raw.githubusercontent.com/jluttine/rofi-power-menu/master/rofi-power-menu
      sudo mv rofi-power-menu /usr/local/bin
      sudo chmod +x /usr/local/bin/rofi-power-menu
      cd
  else
      echo "rofi-power-menu is already installed"
  fi
   
  # rofi-bluetooth (own fork using my custom theme)
  if ! command -v rofi-bluetooth &> /dev/null; then
      cd /tmp
      wget https://raw.githubusercontent.com/carldelfin/rofi-bluetooth/master/rofi-bluetooth
      sudo mv rofi-bluetooth /usr/local/bin
      sudo chmod +x /usr/local/bin/rofi-bluetooth
      cd
  else
      echo "rofi-bluetooth is already installed"
  fi
  
  # Mullvad
  #if ! command -v mullvad &> /dev/null; then
  #    cd /tmp
  #    wget https://mullvad.net/media/app/MullvadVPN-2021.3_amd64.deb
  #    sudo apt install -y ./*.deb
  #    rm *.deb
  #    cd
  #else
  #    echo "Mullvad is already installed"
  #fi

  # neovim
  if ! command -v nvim &> /dev/null; then
      cd /tmp
      curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
      chmod u+x nvim.appimage
      sudo mv nvim.appimage /usr/bin/
      cd
      
      pip3 install pynvim

  else
      echo "Neovim is already installed"
  fi

  # vim-plug
  if [ -d "$HOME/.vim/plugged" ]; then
      echo "vim-plug is already installed"
  else
      sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  fi
}

simple
echo ""
echo -e "\033[1;32mEverything is set up, time to reboot!\033[0m"
echo ""
