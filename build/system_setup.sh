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
        cmake kitty yambar wofi wofi-pass ufw rsync curl zathura \
        syncthing htop swaylock \
        inkscape mpv brightnessctl lua5.4
        #pinentry-qt \

    # river
     sudo wget -O /usr/share/keyrings/nickh-archive-keyring.gpg https://www.ne.jp/asahi/nickh/debian/nickh-archive-keyring.gpg
     echo "deb [signed-by=/usr/share/keyrings/nickh-archive-keyring.gpg] https://www.ne.jp/asahi/nickh/debian/ bookworm/" | sudo tee /etc/apt/sources.list.d/nickh.list
     sudo apt update
     sudo apt install -y river

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
        sudo virsh net-start default
        sudo virsh net-autostart default
        sudo modprobe vhost_net
        sudo usermod -a -G libvirt $(whoami)
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

    # ----------------------------------------------------------------------------------------------
    # Appearance
    # ----------------------------------------------------------------------------------------------

    echo ""
    echo -e "\033[1;35mInstalling theme, icons, fonts...\033[0m"
    echo ""
        
    mkdir -p ~/.local/share/fonts

    # jetbrainsmono with nerd font patch
    if fc-list | grep -q JetBrains; then
        echo ""
        echo -e "\033[0;35mJetBrainsMono is already installed, skipping...\033[0m"
        echo ""
    else
        cd ~/.local/share/fonts
        wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip
        unzip *.zip
        rm *.zip
    fi

    # font awesome
    if fc-list | grep -q "Font Awesome"; then
        echo ""
        echo -e "\033[0;35Font Awesome is already installed, skipping...\033[0m"
        echo ""
    else
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

    sudo chmod +x ~/dotfiles/config/river/init

    # ----------------------------------------------------------------------------------------------
    # Directories, symlinks, and configs
    # ----------------------------------------------------------------------------------------------

    echo ""
    echo -e "\033[1;35mSetting up directories and symlinks...\033[0m"
    echo ""

    # create missing directories and files
    mkdir -p $HOME/.config/{river,kitty,yambar,zathura}

    # symlinks
    ln -s -f ~/dotfiles/config/river/init ~/.config/river/init
    ln -s -f ~/dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
    ln -s -f ~/dotfiles/config/yambar/config.yml ~/.config/yambar/config.yml
    ln -s -f ~/dotfiles/config/zathura/zathurarc ~/.config/zathura/zathurarc
    ln -s -f ~/dotfiles/config/environment.d ~/.config/environment.d

    # kitty color scheme
    mkdir -p ~/.config/kitty/themes
    cd ~/.config/kitty/themes
    wget https://github.com/edeneast/nightfox.nvim/raw/main/extra/nordfox/nightfox_kitty.conf 
    cd

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
        sudo ufw allow from 192.168.20.0/24 to any port 22 # allow ssh connections from within LAN
        sudo ufw enable
        sudo ufw allow syncthing
    fi

    # ----------------------------------------------------------------------------------------------
    # Fix slow start-up for GTK apps
    # ----------------------------------------------------------------------------------------------

    #sudo apt remove -y xdg-desktop-portal-gtk xdg-desktop-portal-gnome
    #sudo apt autoremove -y

}

simple

echo ""
echo -e "\033[1;32mEverything is set up, time to reboot!\033[0m"
echo ""
