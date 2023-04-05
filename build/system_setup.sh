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
        make cmake python3-pip kitty polybar suckless-tools rofi pass pinentry-gnome3 \
        ufw rsync unzip curl network-manager xinput feh arandr zathura ranger fzf scrot \
        syncthing zoxide htop alsa-utils pulseaudio libavcodec-extra qpdfview inkscape \
        firefox-esr exfat-fuse libreoffice udiskie mpv lightdm xsecurelock psmisc zsh zplug 

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

    # go
    if ! command -v go version &> /dev/null; then
        cd /tmp
        wget https://golang.org/dl/go1.17.7.linux-amd64.tar.gz
        sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.17.7.linux-amd64.tar.gz
        rm go1.17.7.linux-amd64.tar.gz
        cd
    else
        echo ""
        echo -e "\033[0;35mGo is already installed, skipping...\033[0m"
        echo ""
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

    # neovim
    if ! command -v nvim &> /dev/null; then
        cd /tmp
        wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.deb
        sudo apt install -y ./nvim-linux64.deb
        rm nvim-linux64.deb

        pip3 install pynvim

    else
        echo ""
        echo -e "\033[0;35mNeovim is already installed, skipping...\033[0m"
        echo ""
    fi

    # ----------------------------------------------------------------------------------------------
    # Appearance
    # ----------------------------------------------------------------------------------------------
    
    echo ""
    echo -e "\033[1;35mInstalling theme, icons, fonts...\033[0m"
    echo ""

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
    sudo chmod +x ~/dotfiles/scripts/vpn.sh
    sudo chmod +x ~/dotfiles/scripts/backup.sh
    sudo chmod +x ~/dotfiles/scripts/keyboard_toggle.sh

    # ----------------------------------------------------------------------------------------------
    # Directories, symlinks, and configs
    # ----------------------------------------------------------------------------------------------

    echo ""
    echo -e "\033[1;35mSetting up directories and symlinks...\033[0m"
    echo ""

    # create missing directories and files
    mkdir -p ~/.config/{bspwm,sxhkd,kitty,ranger,rofi,rofi-pass,nvim,.gtkrc-2.0,gtk-3.0,zathura,lightdm}
    mkdir -p ~/.icons/default
    touch ~/.icons/default/index.theme

    # copy ranger config
    ranger --copy-config=all

    # symlinks 
    ln -s -f ~/dotfiles/config/zsh/.zshrc ~/.zshrc
    ln -s -f ~/dotfiles/config/.inputrc ~/.inputrc
    ln -s -f ~/dotfiles/config/gtk/.gtkrc-2.0 ~/.config/.gtkrc-2.0
    ln -s -f ~/dotfiles/config/gtk/settings.ini ~/.config/gtk-3.0/settings.ini
    ln -s -f ~/dotfiles/config/mimeapps.list ~/.config/mimeapps.list
    ln -s -f ~/dotfiles/config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
    ln -s -f ~/dotfiles/config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
    ln -s -f ~/dotfiles/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
    ln -s -f ~/dotfiles/config/ranger/rifle.conf ~/.config/ranger/rifle.conf
    ln -s -f ~/dotfiles/config/ranger/rc.conf ~/.config/ranger/rc.conf
    ln -s -f ~/dotfiles/config/ranger/commands.py ~/.config/ranger/commands.py
    ln -s -f ~/dotfiles/config/rofi/oner.rasi ~/.config/rofi/oner.rasi
    ln -s -f ~/dotfiles/config/rofi-pass/config ~/.config/rofi-pass/config
    ln -s -f ~/dotfiles/config/nvim/* ~/.config/nvim/
    ln -s -f ~/dotfiles/config/zathura/zathurarc ~/.config/zathura/zathurarc
    ln -s -f ~/dotfiles/config/index.theme ~/.icons/default/index.theme
    sudo ln -s -f ~/dotfiles/config/index.theme /usr/share/icons/default/index.theme
    sudo ln -s -f ~/dotfiles/config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf 

    # ----------------------------------------------------------------------------------------------
    # Ranger setup
    # ----------------------------------------------------------------------------------------------

    echo ""
    echo -e "\033[1;35mSetting up ranger...\033[0m"
    echo ""

    # ranger zoxide
    if [ ! -d "/home/cmd/.config/ranger/plugins/zoxide" ]; then
        git clone https://github.com/jchook/ranger-zoxide.git ~/.config/ranger/plugins/zoxide
    else
        echo ""
        echo -e "\033[0;35ranger zoxide is already installed, skipping...\033[0m"
        echo ""
    fi

    # devicons2
    if [ ! -d "/home/cmd/.config/ranger/plugins/devicons2" ]; then
        git clone https://github.com/cdump/ranger-devicons2 ~/.config/ranger/plugins/devicons2
    else
        echo ""
        echo -e "\033[0;35ranger devicons2 is already installed, skipping...\033[0m"
        echo ""
    fi

    # ----------------------------------------------------------------------------------------------
    # Neovim setup
    # ----------------------------------------------------------------------------------------------

    echo ""
    echo -e "\033[1;35mSetting up Neovim...\033[0m"
    echo ""

    # vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # install plugins
    nvim --headless +PlugInstall +qall

    # make hexokinase
    export PATH=$PATH:/usr/local/go/bin
    cd ~/.vim/plugged/vim-hexokinase
    make hexokinase
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
    # Make zsh default shell 
    # ----------------------------------------------------------------------------------------------
    
    echo ""
    echo -e "\033[1;35mMaking zsh default shell...\033[0m"
    echo ""
    
    chsh -s /bin/zsh

}

simple

echo ""
echo -e "\033[1;32mEverything is set up, time to reboot!\033[0m"
echo ""
