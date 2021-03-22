#!/bin/bash

####################################################################################################
#
# This script installs things that are required either by the system or by me. Although larger 
# applications are installed using separate scripts, please note that quite a lot is installed 
# during system setup as well. In addition, UFW is configured, and several symlinks are setup.
#
# As always, do not blindly use this script!
#
####################################################################################################

# ==================================================================================================
# Define a try catch function
# Based on: https://medium.com/@dirk.avery/the-bash-trap-trap-ce6083f36700
# ==================================================================================================

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
  # Install packages
  # ==================================================================================================
  
  # --------------------------------------------------------------------------------------------------
  # Essentials
  # --------------------------------------------------------------------------------------------------
  
  echo ""
  echo -e "\033[1;33mInstalling system essentials...\033[0m"
  echo ""
  
  sudo apt install -y \
  xorg bspwm picom kitty polybar suckless-tools rofi \
  pass ufw rsync unzip curl make gcc hsetroot arandr ranger \
  nautilus lightdm jq syncthing apt-listbugs
  
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
  if ! command -v mullvad &> /dev/null; then
      cd /tmp
      wget https://mullvad.net/media/app/MullvadVPN-2020.7_amd64.deb
      sudo apt install -y ./*.deb
      rm *.deb
      cd
  else
      echo "Mullvad is already installed"
  fi
  
  # --------------------------------------------------------------------------------------------------
  # Day-to-day applications
  # --------------------------------------------------------------------------------------------------
  
  echo ""
  echo -e "\033[1;33mInstalling day-to-day applications...\033[0m"
  echo ""
  
  sudo apt install -y neovim inkscape zathura qpdf htop firefox-esr
  
  # vim-plug
  if [ -d "$HOME/.vim/plugged" ]; then
      echo "vim-plug is already installed"
  else
      sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  fi

  # --------------------------------------------------------------------------------------------------
  # Virtual machines
  # --------------------------------------------------------------------------------------------------
  
  echo ""
  echo -e "\033[1;33mInstalling QEMU/KVM...\033[0m"
  echo ""
  
  sudo apt install -y \
  qemu-system libvirt-daemon-system libvirt-clients virt-manager bridge-utils
  
  sudo adduser `id -un` libvirt
  sudo adduser `id -un` kvm
  
  # --------------------------------------------------------------------------------------------------
  # Sound
  # --------------------------------------------------------------------------------------------------
  
  echo ""
  echo -e "\033[1;33mInstalling sound packages...\033[0m"
  echo ""
  
  sudo apt install -y alsa-utils pulseaudio libavcodec-extra 
  
  # --------------------------------------------------------------------------------------------------
  # Appearance
  # --------------------------------------------------------------------------------------------------
  
  echo ""
  echo -e "\033[1;33mInstalling themes and fonts...\033[0m"
  echo ""
  
  sudo apt install -y \
  materia-gtk-theme papirus-icon-theme neofetch
  
  # Fira Code font
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

  # Font Awesome
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
  
  # Fira Sans
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
  
  # --------------------------------------------------------------------------------------------------
  # Remove unecessary packages
  # --------------------------------------------------------------------------------------------------
 
  sudo apt remove nano 

  # ==================================================================================================
  # Make sure relevant configs and scripts are executable
  # ==================================================================================================
  
  echo ""
  echo -e "\033[1;33mMaking sure configs and scripts are executable...\033[0m"
  echo ""
  
  sudo chmod +x ~/dotfiles/config/bspwm/bspwmrc
  sudo chmod +x ~/dotfiles/scripts/launch.sh
  sudo chmod +x ~/dotfiles/scripts/vpn.sh
  sudo chmod +x ~/dotfiles/scripts/sync.sh
  sudo chmod +x ~/dotfiles/scripts/upgrades.sh
  sudo chmod +x ~/dotfiles/scripts/backup.sh
  sudo chmod +x ~/dotfiles/scripts/weather.R

  # ==================================================================================================
  # Set up symlinks and paths
  # ==================================================================================================
  
  echo ""
  echo -e "\033[1;33mSetting up symlinks and paths...\033[0m"
  echo ""
  
  mkdir -p ~/.config/{bspwm,sxhkd,kitty,rofi,rofi-pass,ranger,nvim,gtk-3.0}
  ranger --copy-config=all

  ln -s -f ~/dotfiles/config/.bashrc ~/.bashrc
  ln -s -f ~/dotfiles/config/.bash_functions ~/.bash_functions
  ln -s -f ~/dotfiles/config/.xinitrc ~/.xinitrc
  ln -s -f ~/dotfiles/config/.xsessionrc ~/.xsessionrc
  ln -s -f ~/dotfiles/config/gtk/.gtkrc-2.0 ~/.config/.gtkrc-2.0
  ln -s -f ~/dotfiles/config/gtk/settings.ini ~/.config/gtk-3.0/settings.ini
  ln -s -f ~/dotfiles/config/mimeapps.list ~/.config/mimeapps.list
  ln -s -f ~/dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
  ln -s -f ~/dotfiles/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
  ln -s -f ~/dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
  ln -s -f ~/dotfiles/config/rofi/my_theme.rasi ~/.config/rofi/my_theme.rasi
  ln -s -f ~/dotfiles/config/rofi-pass/config ~/.config/rofi-pass/config
  ln -s -f ~/dotfiles/config/ranger/rifle.conf ~/.config/ranger/rifle.conf
  ln -s -f ~/dotfiles/config/ranger/rc.conf ~/.config/ranger/rc.conf
  ln -s -f ~/dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
  
  # ==================================================================================================
  # Configure UFW
  # ==================================================================================================
  
  echo ""
  echo -e "\033[1;33mConfiguring UFW...\033[0m"
  echo ""
  
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw allow from 192.168.20.0/24 to any port 22 # allow ssh connections from within LAN
  sudo ufw enable
  sudo ufw allow syncthing
 
}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mSystem setup OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
