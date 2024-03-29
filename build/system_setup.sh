#!/bin/bash

set -e
trap 'catch $? $LINENO' EXIT

catch() {
    if [ "$1" != "0" ]; then
        echo ""
        echo -e "\033[1;31mInstallation failed!\033[0m"
        echo -e "\033[1;31mError $1 occurred on $2\033[0m"
        echo ""
    fi
}

simple() {
    
    # ----------------------------------------------------------------------------------------------
    # Applications 
    # ----------------------------------------------------------------------------------------------

    echo ""
    echo -e "\033[1;35mInstalling applications...\033[0m"
    echo ""

    sudo apt install -y \
        xorg bspwm picom build-essential apt-transport-https software-properties-common \
        make cmake polybar suckless-tools rofi pass pinentry-gnome3 lua5.4 \
        ufw rsync unzip curl network-manager xinput feh arandr zathura scrot npm \
        syncthing htop alsa-utils pulseaudio libavcodec-extra qpdfview inkscape \
        firefox-esr exfat-fuse libreoffice udiskie mpv lightdm xsecurelock psmisc \
        brightnessctl

    # kvm/qemu 
    if [[ $(systemd-detect-virt) = *kvm* ]]; then
        echo ""
        echo -e "\033[0;35mInside a virtual machine, skipping KVM/QEMU install...\033[0m"
        echo ""
    else
        echo ""
        echo -e "\033[1;35mInstalling KVM/QEMU...\033[0m"
        echo ""
        sudo apt install -y \
            qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst \
            libvirt-daemon virt-manager
        #sudo virsh net-start default
        #sudo virsh net-autostart default
        #sudo modprobe vhost_net
        #sudo usermod -a -G libvirt $(whoami)
    fi

    # passmenu
    if ! command -v passmenu &> /dev/null; then
        sudo cp /usr/share/doc/pass/examples/dmenu/passmenu /usr/bin/passmenu
        sudo chmod +x /usr/bin/passmenu
    else
        echo ""
        echo -e "\033[0;35mpassmenu is already installed, skipping...\033[0m"
        echo ""
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
        echo ""
        echo -e "\033[0;35mrofi-pass is already installed, skipping...\033[0m"
        echo ""
    fi

    # rofi-power-menu
    if ! command -v rofi-power-menu &> /dev/null; then
        cd /tmp
        wget https://raw.githubusercontent.com/jluttine/rofi-power-menu/master/rofi-power-menu
        sudo mv rofi-power-menu /usr/local/bin
        sudo chmod +x /usr/local/bin/rofi-power-menu
        cd
    else
        echo ""
        echo -e "\033[0;35mrofi-power-menu is already installed, skipping...\033[0m"
        echo ""
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
        echo ""
        echo -e "\033[0;35mMullvad is already installed, skipping...\033[0m"
        echo ""
    fi

    # wezterm
    if ! command -v wezterm &> /dev/null; then
        curl -LO https://github.com/wez/wezterm/releases/download/20230408-112425-69ae8472/WezTerm-20230408-112425-69ae8472-Ubuntu20.04.AppImage
        chmod +x WezTerm-20230408-112425-69ae8472-Ubuntu20.04.AppImage
        mkdir -p $HOME/.local/bin
        mv ./WezTerm-20230408-112425-69ae8472-Ubuntu20.04.AppImage $HOME/.local/bin/wezterm
    else
        echo ""
        echo -e "\033[0;35mWezTerm is already installed, skipping...\033[0m"
        echo ""
    fi


    # ----------------------------------------------------------------------------------------------
    # Appearance
    # ----------------------------------------------------------------------------------------------
    
    echo ""
    echo -e "\033[1;35mInstalling theme, icons, fonts...\033[0m"
    echo ""

    # arc gtk
    sudo apt install -y gtk2-engines-murrine arc-theme

    # papirus icons
    sudo sh -c "echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu focal main' > /etc/apt/sources.list.d/papirus-ppa.list"
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com E58A9D36647CAE7F
    sudo apt update
    sudo apt install papirus-icon-theme libreoffice-style-papirus

    # jetbrainsmono with nerd font patch
    if fc-list | grep -q JetBrains; then
        echo ""
        echo -e "\033[0;35mJetBrainsMono is already installed, skipping...\033[0m"
        echo ""
    else
        mkdir -p ~/.local/share/fonts
        cd ~/.local/share/fonts
        wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
        unzip *.zip
        rm *.zip
    fi

    # various google fonts
    if fc-list | grep -q "Fira Sans"; then
        echo ""
        echo -e "\033[0;35mGoogle fonts are already installed, skipping...\033[0m"
        echo ""
    else
        mkdir -p ~/.local/share/fonts
        cd /tmp
        wget -O fonts.zip "https://fonts.google.com/download?family=Fira%20Sans|Fira%20Sans%20Condensed|Fira%20Sans%20Extra%20Condensed|Fira%20Mono"
        unzip fonts.zip -d ~/.local/share/fonts
        rm -rf *.zip
        cd
    fi

    # font awesome
    if fc-list | grep -q "Font Awesome"; then
        echo ""
        echo -e "\033[0;35Font Awesome is already installed, skipping...\033[0m"
        echo ""
    else
        mkdir -p ~/.local/share/fonts
        cd /tmp
        wget https://use.fontawesome.com/releases/v6.0.0/fontawesome-free-6.0.0-desktop.zip
        unzip *.zip
        mv fontawesome-free-6.0.0-desktop/otfs/*.otf ~/.local/share/fonts/
        rm *.zip
        rm -rf fontawesome-free-6.0.0-desktop
        cd
    fi

    fc-cache -f

    # phinger cursors
    if [ ! -d "/usr/share/icons/phinger-cursors" ]; then
        wget -cO- https://github.com/phisch/phinger-cursors/releases/latest/download/phinger-cursors-variants.tar.bz2 | sudo tar xfj - -C /usr/share/icons
    else
        echo ""
        echo -e "\033[0;35phinger-cursors is already installed, skipping...\033[0m"
        echo ""
    fi

    # ----------------------------------------------------------------------------------------------
    # Permissions
    # ----------------------------------------------------------------------------------------------
    
    echo ""
    echo -e "\033[1;35mMaking sure configs and scripts are executable...\033[0m"
    echo ""

    sudo chmod +x ~/dotfiles/config/bspwm/bspwmrc
    sudo chmod +x ~/dotfiles/scripts/launch.sh

    # ----------------------------------------------------------------------------------------------
    # Directories, symlinks, and configs
    # ----------------------------------------------------------------------------------------------

    echo ""
    echo -e "\033[1;35mSetting up directories and symlinks...\033[0m"
    echo ""

    # create missing directories and files
    mkdir -p ~/.config/{bspwm,sxhkd,wezterm,rofi,rofi-pass,gtkrc-2.0,gtk-3.0,zathura,lightdm}
    mkdir -p ~/.icons/default
    touch ~/.icons/default/index.theme

    # symlinks
    ln -s -f ~/dotfiles/config/.inputrc ~/.inputrc
    ln -s -f ~/dotfiles/config/gtk/.gtkrc-2.0 ~/.config/.gtkrc-2.0
    ln -s -f ~/dotfiles/config/gtk/settings.ini ~/.config/gtk-3.0/settings.ini
    ln -s -f ~/dotfiles/config/mimeapps.list ~/.config/mimeapps.list
    ln -s -f ~/dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
    ln -s -f ~/dotfiles/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
    ln -s -f ~/dotfiles/config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
    ln -s -f ~/dotfiles/config/rofi/oner.rasi ~/.config/rofi/oner.rasi
    ln -s -f ~/dotfiles/config/rofi-pass/config ~/.config/rofi-pass/config
    ln -s -f ~/dotfiles/config/zathura/zathurarc ~/.config/zathura/zathurarc
    ln -s -f ~/dotfiles/config/index.theme ~/.icons/default/index.theme
    sudo ln -s -f ~/dotfiles/config/index.theme /usr/share/icons/default/index.theme
    sudo ln -s -f ~/dotfiles/config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf

    # ----------------------------------------------------------------------------------------------
    # Configure ufw
    # ----------------------------------------------------------------------------------------------
  
    # inside a VM? 
    if [[ $(systemd-detect-virt) = *kvm* ]]; then
        echo ""
        echo -e "\033[0;35mInside a virtual machine, skipping UFW setup...\033[0m"
        echo ""
    else
        echo ""
        echo -e "\033[1;35mConfiguring UFW...\033[0m"
        echo ""
    
        sudo ufw default deny incoming
        sudo ufw default allow outgoing
        sudo ufw enable
        sudo ufw allow syncthing
    fi
    
    # ----------------------------------------------------------------------------------------------
    # Change GRUB background
    # ----------------------------------------------------------------------------------------------
    
    echo ""
    echo -e "\033[1;35mChanging GRUB background...\033[0m"
    echo ""

    sudo cp ~/dotfiles/wallpaper/wallpaper.png /boot/grub
    sudo update-grub

}

simple

echo ""
echo -e "\033[1;32mEverything is set up, time to reboot!\033[0m"
echo ""
