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
        firefox-esr exfat-fuse libreoffice udiskie mpv npm lightdm xsecurelock

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
    if ! command -v /usr/bin/nvim.appimage &> /dev/null; then
        cd /tmp
        curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
        chmod u+x nvim.appimage
        sudo mv nvim.appimage /usr/bin/
        cd

        pip3 install pynvim

    else
        echo ""
        echo -e "\033[0;35mNeovim is already installed, skipping...\033[0m"
        echo ""
    fi

    # giph
    if ! command -v giph &> /dev/null; then
        git clone https://github.com/phisch/giph.git
        cd giph
        sudo make install
        cd ..
        rm -rf giph

        # dependencies 
        sudo apt install -y slop ffmpeg xdotool
    else
        echo ""
        echo -e "\033[0;35mgiph is already installed, skipping...\033[0m"
        echo ""
    fi

    # todo.txt-cli
    if ! command -v todo.sh &> /dev/null; then
        mkdir -p ~/.todo
        cd /tmp
        wget https://github.com/todotxt/todo.txt-cli/archive/refs/tags/v2.12.0.zip
        unzip *.zip
        cd todo.txt-cli-2.12.0
        sudo make install INSTALL_DIR=/usr/bin
        cp /usr/local/etc/todo/config ~/.todo/config
    else
        echo ""
        echo -e "\033[0;35mtodo.txt-cli is already installed, skipping...\033[0m"
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
        wget -O fonts.zip "https://fonts.google.com/download?family=Roboto|Noto%20Sans|Open%20Sans|Roboto%20Condensed|Source%20Sans%20Pro|Raleway|Merriweather|Roboto%20Slab|PT%20Sans|Open%20Sans%20Condensed|Droid%20Sans|Droid%20Serif|Fira%20Sans|Fira%20Sans%20Condensed|Fira%20Sans%20Extra%20Condensed|Fira%20Mono"
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

    # material design icons
    if fc-list | grep -q "Material"; then
        echo ""
        echo -e "\033[0;35Material Icons are already installed, skipping...\033[0m"
        echo ""
    else
        cd /tmp
        wget https://github.com/google/material-design-icons/releases/download/3.0.1/material-design-icons-3.0.1.zip
        unzip *.zip
        mv material-design-icons-3.0.1/iconfont/*.ttf ~/.local/share/fonts/
        rm *.zip
        rm -rf material-design-icons-3.0.1
        cd
    fi


    fc-cache -f

    # phinger cursors
    if [ ! -d "/use/share/icons/phinger-cursors" ]; then
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

    # symlink configs
    ln -s -f ~/dotfiles/config/.bashrc ~/.bashrc
    ln -s -f ~/dotfiles/config/.bash_functions ~/.bash_functions
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
    ln -s -f ~/dotfiles/config/rofi/ayur.rasi ~/.config/rofi/ayur.rasi
    ln -s -f ~/dotfiles/config/rofi-pass/config ~/.config/rofi-pass/config
    ln -s -f ~/dotfiles/config/nvim/* ~/.config/nvim/
    ln -s -f ~/dotfiles/config/zathura/zathurarc ~/.config/zathura/zathurarc
    ln -s -f ~/dotfiles/config/index.theme ~/.icons/default/index.theme
    sudo ln -s -f ~/dotfiles/config/index.theme /usr/share/icons/default/index.theme
    sudo ln -s -f ~/dotfiles/config/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf 
    ln -s -f ~/dotfiles/config/todo/config ~/.todo/config

    # ----------------------------------------------------------------------------------------------
    # Ranger setup
    # ----------------------------------------------------------------------------------------------

    echo ""
    echo -e "\033[1;33mSetting up ranger...\033[0m"
    echo ""

    # ranger zoxide
    if [ ! -d "/home/cmd/.config/ranger/plugins/zoxide" ]; then
        git clone https://github.com/jchook/ranger-zoxide.git ~/.config/ranger/plugins/zoxide
    else
        echo -e "\033[0;35ranger zoxide is already installed, skipping...\033[0m"
    fi

    # devicons2
    if [ ! -d "/home/cmd/.config/ranger/plugins/devicons2" ]; then
        git clone https://github.com/cdump/ranger-devicons2 ~/.config/ranger/plugins/devicons2
    else
        echo -e "\033[0;35ranger devicons2 is already installed, skipping...\033[0m"
    fi

    # ----------------------------------------------------------------------------------------------
    # Neovim setup
    # -----------------------------------------------------------------------------------------------

    echo ""
    echo -e "\033[1;33mSetting up Neovim...\033[0m"
    echo ""

    # vim-plug
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    # install plugins
    /usr/bin/nvim.appimage --headless +PlugInstall +qall

    # make hexokinase
    export PATH=$PATH:/usr/local/go/bin
    cd ~/.vim/plugged/vim-hexokinase
    make hexokinase
    cd

    # install language servers
    sudo npm i -g bash-language-server
    sudo npm i -g pyright

    cd /tmp
    wget https://github.com/valentjn/ltex-ls/releases/download/15.2.0/ltex-ls-15.2.0-linux-x64.tar.gz
    mkdir -p ~/.local/bin
    tar -C ~/.local/bin -xzf ltex-ls-15.2.0-linux-x64.tar.gz
    rm ltex-ls-15.2.0-linux-x64.tar.gz

    # ------------------------------------------------------------------------------------------------
    # Configure ufw
    # ------------------------------------------------------------------------------------------------
  
    # inside a VM? 
    if [[ $(systemd-detect-virt) = *kvm* ]]; then
        echo -e "\033[0;35mInside a virtual machine, skipping UFW setup...\033[0m"
    else
        echo ""
        echo -e "\033[1;33mConfiguring UFW...\033[0m"
        echo ""
    
        sudo ufw default deny incoming
        sudo ufw default allow outgoing
        sudo ufw allow from 192.168.20.0/24 to any port 22 # allow ssh connections from within LAN
        sudo ufw enable
        sudo ufw allow syncthing
    fi
}

simple

echo ""
echo -e "\033[1;32mEverything is set up, time to reboot!\033[0m"
echo ""
