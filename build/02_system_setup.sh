#!/bin/bash

# ==============================================================================
# Define a try catch function
# Based on: https://medium.com/@dirk.avery/the-bash-trap-trap-ce6083f36700
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

  # ==============================================================================
  # Begin installation
  # ==============================================================================

  # ------------------------------------------------------------------------------
  # Essential packages
  # ------------------------------------------------------------------------------

  sudo apt install -y \
  xorg bspwm kitty polybar suckless-tools rofi pass \
  make meson gcc unzip curl ufw lxappearance apt-listbugs \
  alsa-utils pulseaudio libavcodec-extra qpdf \
  okular ranger feh syncthing arandr htop python-pip \
  neofetch jq neovim qt5-style-plugins firefox-esr \
  rsync materia-gtk-theme papirus-icon-theme
  
  # 
  # picom
  # 
  
  sudo apt install -y \
  libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev \
  libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev \
  libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev \
  libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev \
  libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev
  
  git clone https://github.com/yshui/picom
  cd picom
  git submodule update --init --recursive
  meson --buildtype=release . build
  sudo ninja -C build install
  
  # ------------------------------------------------------------------------------
  # vim-plug
  # https://github.com/junegunn/vim-plug
  # ------------------------------------------------------------------------------
  
  if [ -d "$HOME/.vim/plugged" ]; then
      echo "vim-plug is already installed"
  else
      sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  fi
  
  # ------------------------------------------------------------------------------
  # passmenu
  # ------------------------------------------------------------------------------
  
  if ! command -v passmenu &> /dev/null; then
      sudo cp /usr/share/doc/pass/examples/dmenu/passmenu /usr/bin/passmenu
      sudo chmod +x /usr/bin/passmenu
  else
      echo "passmenu is already installed"
  fi

  # ------------------------------------------------------------------------------
  # rofi-pass
  # https://github.com/carnager/rofi-pass
  # ------------------------------------------------------------------------------
  
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
  
  # ------------------------------------------------------------------------------
  # rofi-power-menu
  # https://github.com/jluttine/rofi-power-menu
  # ------------------------------------------------------------------------------

  if ! command -v rofi-power-menu &> /dev/null; then
      cd /tmp
      wget https://raw.githubusercontent.com/jluttine/rofi-power-menu/master/rofi-power-menu
      sudo mv rofi-power-menu /usr/local/bin
      sudo chmod +x /usr/local/bin/rofi-power-menu
      cd
  else
      echo "rofi-power-menu is already installed"
  fi
 
  # ------------------------------------------------------------------------------
  # rofi-bluetooth
  # https://github.com/ClydeDroid/rofi-bluetooth
  # ------------------------------------------------------------------------------

  if ! command -v rofi-bluetooth &> /dev/null; then
      cd /tmp
      wget https://raw.githubusercontent.com/ClydeDroid/rofi-bluetooth/master/rofi-bluetooth
      sudo mv rofi-bluetooth /usr/local/bin
      sudo chmod +x /usr/local/bin/rofi-bluetooth
      cd
  else
      echo "rofi-bluetooth is already installed"
  fi
  
  # ------------------------------------------------------------------------------
  # Mullvad
  # https://mullvad.net
  # ------------------------------------------------------------------------------
  
  if ! command -v mullvad &> /dev/null; then
      cd /tmp
      wget https://mullvad.net/media/app/MullvadVPN-2020.7_amd64.deb
      sudo apt install -y ./*.deb
      rm *.deb
      cd
  else
      echo "Mullvad is already installed"
  fi
  
  # ==============================================================================
  # Install fonts 
  # ==============================================================================
  
  # ------------------------------------------------------------------------------
  # Fira Code
  # https://github.com/tonsky/FiraCode
  # ------------------------------------------------------------------------------
  
  if fc-list | grep -q FiraCode; then
    echo "Fira Code is already installed"
  else
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
  fi

  # ------------------------------------------------------------------------------
  # Font Awesome
  # https://fontawesome.com/
  # ------------------------------------------------------------------------------
  
  if fc-list | grep -q "Font Awesome"; then
    echo "Font Awesome is already installed"
  else
    mkdir -p ~/.local/share/fonts
    cd /tmp
    wget https://use.fontawesome.com/releases/v5.15.2/fontawesome-free-5.15.2-desktop.zip
    unzip *.zip
    mv fontawesome-free-5.15.2-desktop/otfs/*.otf ~/.local/share/fonts/
    rm *.zip
    rm -rf fontawesome-free-5.15.2-desktop
    cd
  fi
  
  # ------------------------------------------------------------------------------
  # Fira Sans
  # https://github.com/pop-os/fonts
  # ------------------------------------------------------------------------------
  
  if fc-list | grep -q "Fira Sans"; then
    echo "Fira Sans is already installed"
  else
    mkdir -p ~/.local/share/fonts
    cd /tmp
    wget https://github.com/pop-os/fonts/archive/master.zip
    unzip *.zip
    mv fonts-master/fira/*.otf ~/.local/share/fonts/
    rm *.zip
    rm -rf fonts-master
    cd
  fi
  
  fc-cache -f
  
  # ==============================================================================
  # Make sure relevant configs and scripts are executable
  # ==============================================================================
  
  sudo chmod +x ~/dotfiles/config/bspwm/bspwmrc
  sudo chmod +x ~/dotfiles/scripts/launch.sh
  sudo chmod +x ~/dotfiles/scripts/vpn.sh
  sudo chmod +x ~/dotfiles/scripts/sync.sh
  sudo chmod +x ~/dotfiles/scripts/upgrades.sh
  sudo chmod +x ~/dotfiles/scripts/backup.sh
  sudo chmod +x ~/dotfiles/scripts/weather.R

  # ==============================================================================
  # Set up symlinks and paths
  # ==============================================================================
  
  mkdir -p ~/.config/{bspwm,sxhkd,kitty,rofi,rofi-pass,ranger,nvim}
  ranger --copy-config=all

  ln -s -f ~/dotfiles/config/.bashrc ~/.bashrc
  ln -s -f ~/dotfiles/config/mimeapps.list ~/.config/mimeapps.list
  ln -s -f ~/dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
  ln -s -f ~/dotfiles/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
  ln -s -f ~/dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
  ln -s -f ~/dotfiles/config/rofi/my_theme.rasi ~/.config/rofi/my_theme.rasi
  ln -s -f ~/dotfiles/config/rofi-pass/config ~/.config/rofi-pass/config
  ln -s -f ~/dotfiles/config/ranger/rifle.conf ~/.config/ranger/rifle.conf
  ln -s -f ~/dotfiles/config/ranger/rc.conf ~/.config/ranger/rc.conf
  ln -s -f ~/dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
  
  if ! cat /etc/environment | grep -q "QT_QPA_PLATFORMTHEME=gtk2"; then
    echo "QT_QPA_PLATFORMTHEME=gtk2" | sudo tee -a /etc/environment
  fi

  # ==============================================================================
  # Enable UFW
  # ==============================================================================
  
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw allow from 192.168.20.0/24
  sudo ufw enable
  sudo ufw allow syncthing
 
}

simple
echo ""
echo -e "\033[1;32mInstall OK\033[0m"
echo ""
