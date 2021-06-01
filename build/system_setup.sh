#!/bin/sh

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
  # Ask for hostname
  # ==================================================================================================

  echo ""
  read -p 'Select hostname: ' system_hostname
  hostnamectl set-hostname $system_hostname

  # ==================================================================================================
  # Make sure system is up to date
  # ==================================================================================================
  
  sudo apt update && sudo apt upgrade -y

  # ==================================================================================================
  # Install packages
  # ==================================================================================================
  
  echo ""
  echo -e "\033[1;33mInstalling packages...\033[0m"
  echo ""
  
  sudo apt install -y \
      bspwm picom kitty polybar suckless-tools rofi pass \
      feh arandr syncthing inkscape zathura ranger python3-pip \
      exfat-fuse exfat-utils htop

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
      wget https://mullvad.net/media/app/MullvadVPN-2021.3_amd64.deb
      sudo apt install -y ./*.deb
      rm *.deb
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
  
  # JetBrainsMono with Nerd Font patch
  if fc-list | grep -q JetBrains; then
      echo "JetBrainsMono is already installed"
  else
      mkdir -p ~/.local/share/fonts
      cd ~/.local/share/fonts
      wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
      unzip *.zip
      rm *.zip
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
  
  fc-cache -f

  # --------------------------------------------------------------------------------------------------
  # Sound
  # --------------------------------------------------------------------------------------------------
  
  echo ""
  echo -e "\033[1;33mInstalling sound packages...\033[0m"
  echo ""
  
  sudo apt install -y libavcodec-extra

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

  # ==================================================================================================
  # Set up directories and symlinks
  # ==================================================================================================
  
  echo ""
  echo -e "\033[1;33mSetting up directories and symlinks...\033[0m"
  echo ""
  
  mkdir -p ~/.config/{bspwm,sxhkd,kitty,rofi,rofi-pass,ranger,nvim,.gtkrc-2.0,gtk-3.0,zathura}
  ranger --copy-config=all

  ln -s -f ~/dotfiles/config/.bashrc ~/.bashrc
  ln -s -f ~/dotfiles/config/.bash_functions ~/.bash_functions
  ln -s -f ~/dotfiles/config/.xinitrc ~/.xinitrc
  ln -s -f ~/dotfiles/config/.xsessionrc ~/.xsessionrc
  ln -s -f ~/dotfiles/config/gtk/.gtkrc-2.0 ~/.config/.gtkrc-2.0
  ln -s -f ~/dotfiles/config/gtk/settings.ini ~/.config/gtk-3.0/settings.ini
  sudo ln -s -f ~/dotfiles/config/gtk/index.theme /usr/share/icons/default/index.theme
  ln -s -f ~/dotfiles/config/mimeapps.list ~/.config/mimeapps.list
  ln -s -f ~/dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
  ln -s -f ~/dotfiles/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
  ln -s -f ~/dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
  ln -s -f ~/dotfiles/config/rofi/my_theme.rasi ~/.config/rofi/my_theme.rasi
  ln -s -f ~/dotfiles/config/rofi-pass/config ~/.config/rofi-pass/config
  ln -s -f ~/dotfiles/config/ranger/rifle.conf ~/.config/ranger/rifle.conf
  ln -s -f ~/dotfiles/config/ranger/rc.conf ~/.config/ranger/rc.conf
  ln -s -f ~/dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
  ln -s -f ~/dotfiles/config/zathura/zathurarc ~/.config/zathura/zathurarc
  
  # now that symlinks are setup, install neovim plugins
  /usr/bin/nvim.appimage --headless +PlugInstall +qall
  
  # ==================================================================================================
  # configure ufw
  # ==================================================================================================
  
  echo ""
  echo -e "\033[1;33mconfiguring ufw...\033[0m"
  echo ""
  
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw allow from 192.168.20.0/24 to any port 22 # allow ssh connections from within lan
  sudo ufw enable
  sudo ufw allow syncthing
  
  # ==================================================================================================
  # setup a cron job for backups (only for primary workstation; neuromancer)
  # ==================================================================================================

  host=$(hostname)
  if [ $host == neuromancer ]; then
      cd /tmp
      crontab -l > tmp_cron
      echo "0 18 * * * bash ~/dotfiles/scripts/backup.sh" >> tmp_cron
      crontab tmp_cron
      rm tmp_cron
      cd
  fi

}

simple

echo ""
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
echo -e "\033[1;32mSystem setup OK\033[0m"
echo -e "\033[1;32m"--------------------------------------------------------------------------------------------------"\033[0m"
