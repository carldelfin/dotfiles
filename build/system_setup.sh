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

  # ==================================================================================================
  # Ask for hostname
  # ==================================================================================================

  echo ""
  read -p 'Select hostname: ' system_hostname
  sudo hostnamectl set-hostname $system_hostname

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
  # Install packages
  # ------------------------------------------------------------------------------

  sudo apt install -y \
  bspwm picom kitty polybar suckless-tools rofi pass \
  apt-transport-https build-essential zathura feh htop \
  syncthing libavcodec-extra python3-pip pandoc ranger \
  xorg unzip ufw rsync firefox-esr alsa-utils pulseaudio curl \
  exfat-fuse libreoffice software-properties-common 
  # make cmake
  #arandr  \
  # build-essential dirmngr make gcc libgtk-3-dev apt-listbugs nautilus \
  # rsync neofetch firefox 
  #  exfat-utils  

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
  
  # mullvad
  if ! command -v mullvad &> /dev/null; then
      cd /tmp
      wget https://mullvad.net/download/app/deb/latest
      cp latest latest.deb
      sudo apt install -y ./latest.deb
      rm latest.deb latest
      cd
  else
      echo "Mullvad is already installed"
  fi

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
  
  # --------------------------------------------------------------------------------------------------
  # Appearance
  # --------------------------------------------------------------------------------------------------
  
  echo ""
  echo -e "\033[1;33mInstalling themes and fonts...\033[0m"
  echo ""

  # tokyo night gtk theme
  #sudo mkdir -p /usr/share/themes
  #cd /tmp
  #wget https://github.com/koiosdev/Tokyo-Night-Linux/archive/refs/heads/master.zip
  #unzip master.zip
  #cd Tokyo-Night-Linux-master/usr/share/themes
  #sudo cp -r TokyoNight /usr/share/themes/
  #cd /tmp
  #rm -rf Tokyo-Night-Linux-master 
  #rm master.zip
  #cd

  # numix icons
  #sudo apt install -y numix-icon-theme
  
  # jetbrainsmono with nerd font patch
  if fc-list | grep -q JetBrains; then
      echo "JetBrainsMono is already installed"
  else
      mkdir -p ~/.local/share/fonts
      cd ~/.local/share/fonts
      wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
      unzip *.zip
      rm *.zip
  fi

  # font awesome
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
  
  # various google fonts
  if fc-list | grep -q "Merriweather"; then
      echo "Google fonts are already installed"
  else
      mkdir -p ~/.local/share/fonts
      cd /tmp
      wget -O fonts.zip "https://fonts.google.com/download?family=Roboto|Noto%20Sans|Open%20Sans|Roboto%20Condensed|Source%20Sans%20Pro|Raleway|Merriweather|Roboto%20Slab|PT%20Sans|Open%20Sans%20Condensed|Droid%20Sans|Droid%20Serif|Fira%20Sans|Fira%20Sans%20Condensed|Fira%20Sans%20Extra%20Condensed|Fira%20Mono"
      unzip fonts.zip -d ~/.local/share/fonts
      rm -rf fonts.zip
      cd
  fi
  
  fc-cache -f
  
  # ==================================================================================================
  # Make sure relevant configs and scripts are executable
  # ==================================================================================================
  
  echo ""
  echo -e "\033[1;33mMaking sure configs and scripts are executable...\033[0m"
  echo ""
  
  sudo chmod +x ~/dotfiles/config/bspwm/bspwmrc
  sudo chmod +x ~/dotfiles/scripts/launch.sh
  sudo chmod +x ~/dotfiles/scripts/vpn.sh
  sudo chmod +x ~/dotfiles/scripts/upgrades.sh
  sudo chmod +x ~/dotfiles/scripts/backup.sh
  
  # ==================================================================================================
  # Set up directories and symlinks
  # ==================================================================================================
  
  echo ""
  echo -e "\033[1;33mSetting up directories and symlinks...\033[0m"
  echo ""
  
  mkdir -p ~/.config/{bspwm,sxhkd,kitty,rofi,rofi-pass,nvim,.gtkrc-2.0,gtk-3.0,zathura}
  mkdir -p ~/.config/nvim/colors

  ln -s -f ~/dotfiles/config/.bashrc ~/.bashrc
  ln -s -f ~/dotfiles/config/.bash_functions ~/.bash_functions
  #ln -s -f ~/dotfiles/config/.inputrc ~/.inputrc
  #ln -s -f ~/dotfiles/config/.xinitrc ~/.xinitrc
  #ln -s -f ~/dotfiles/config/.xsessionrc ~/.xsessionrc
  #ln -s -f ~/dotfiles/config/gtk/.gtkrc-2.0 ~/.config/.gtkrc-2.0
  #ln -s -f ~/dotfiles/config/gtk/settings.ini ~/.config/gtk-3.0/settings.ini
  #sudo ln -s -f ~/dotfiles/config/gtk/index.theme /usr/share/icons/default/index.theme
  ln -s -f ~/dotfiles/config/mimeapps.list ~/.config/mimeapps.list
  ln -s -f ~/dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
  ln -s -f ~/dotfiles/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
  ln -s -f ~/dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
  ln -s -f ~/dotfiles/config/rofi/my_theme.rasi ~/.config/rofi/my_theme.rasi
  ln -s -f ~/dotfiles/config/rofi-pass/config ~/.config/rofi-pass/config
  ln -s -f ~/dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
  ln -s -f ~/dotfiles/config/nvim/colors/southernlights.vim ~/.config/nvim/colors/southernlights.vim
  ln -s -f ~/dotfiles/config/nvim/colors/northernlights.vim ~/.config/nvim/colors/northernlights.vim
  ln -s -f ~/dotfiles/config/zathura/zathurarc ~/.config/zathura/zathurarc
  
  # ==================================================================================================
  # configure ufw
  # ==================================================================================================
  
  echo ""
  echo -e "\033[1;33mConfiguring ufw...\033[0m"
  echo ""
  
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw allow from 192.168.20.0/24 to any port 22 # allow ssh connections from within lan
  sudo ufw enable
  sudo ufw allow syncthing
  
}

simple

echo ""
echo -e "\033[1;32mEverything is set up, time to reboot!\033[0m"
echo ""
