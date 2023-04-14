#!/bin/sh

set -e
trap 'catch $? $LINENO' EXIT

catch() {
    if [ "$1" != "0" ]; then
        echo ""
        echo -e "\033[1;31mSetup failed!\033[0m"
        echo -e "\033[1;31mError $1 occurred on $2\033[0m"
        echo ""
    fi
}

simple() {
    
    # ----------------------------------------------------------------------------------------------
    # Check requirements 
    # ----------------------------------------------------------------------------------------------

    echo ""
    echo -e "\033[1;35mChecking requirements...\033[0m"
    echo ""

    # FUSE (Filesystem in Userspace) is required to use AppImages
    if ! command -v fusermount -V &> /dev/null; then
        echo -e "\033[1;31mFUSE not found!\033[0m"
        exit
    else
        fusermount -V
    fi

    # Lua is required for z.lua
    if ! command -v lua -v &> /dev/null; then
        echo -e "\033[1;31mLua not found!\033[0m"
        exit
    else 
        lua -v
    fi
   
    # npm is required to install LSP servers
    if ! command -v npm -v &> /dev/null; then
        echo -e "\033[1;31mnpm not found!\033[0m"
        exit
    else 
        npm -v
    fi

    # ----------------------------------------------------------------------------------------------
    # Applications
    # ----------------------------------------------------------------------------------------------

    echo ""
    echo -e "\033[1;35mDownloading applications...\033[0m"
    echo ""
    
    mkdir -p $HOME/.local/bin

    # neovim
    if [ -f "$HOME/.local/bin/nvim.appimage" ]; then
        echo -e "\033[0;35mNeovim executable found, skipping...\033[0m"
    else
        cd $HOME/.local/bin
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
        chmod u+x nvim.appimage
        cd
    fi

    # vim-plug
    if [ -d "$HOME/.vim/plugged" ]; then
        echo -e "\033[0;35mvim-plug found, skipping...\033[0m"
    else
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    fi

    # z.lua
    if [ -f "$HOME/.local/bin/z.lua-1.8.16/z.lua" ]; then
        echo -e "\033[0;35mz.lua executable found, skipping...\033[0m"
    else
        cd $HOME/.local/bin
        wget https://github.com/skywind3000/z.lua/archive/refs/tags/1.8.16.tar.gz
        tar -xf *.tar.gz
        rm *tar.gz
        cd
    fi

    # ranger
    if [ -f "$HOME/.local/bin/ranger-1.9.3/ranger.py" ]; then
        echo -e "\033[0;35mranger executable found, skipping...\033[0m"
    else
	cd $HOME/.local/bin
        wget https://github.com/ranger/ranger/archive/refs/tags/v1.9.3.tar.gz
        tar -xf *.tar.gz
        rm *tar.gz
        cd
    fi

    # fzf
    if [ -f "$HOME/.local/bin/fzf" ]; then
        echo -e "\033[0;35mfzf executable found, skipping...\033[0m"
    else
        cd $HOME/.local/bin
        wget https://github.com/junegunn/fzf/releases/download/0.39.0/fzf-0.39.0-linux_amd64.tar.gz
        tar -xf *.tar.gz
        rm *tar.gz
        cd
    fi

    # ----------------------------------------------------------------------------------------------
    # Configs
    # ----------------------------------------------------------------------------------------------
   
    echo ""
    echo -e "\033[1;35mSetting up directories and configs...\033[0m"
    echo ""
    
    # create config directories
    mkdir -p $HOME/.config/{nvim,ranger}
    
    # append to .bashrc
    cat $HOME/dotfiles/config/bash/bashrc_additions >> $HOME/.bashrc
    
    # copy ranger config
    python3 $HOME/.local/bin/ranger-1.9.3/ranger.py --copy-config=all

    # symlink configs
    ln -s -f $HOME/dotfiles/config/nvim/* ~/.config/nvim/
    ln -s -f $HOME/dotfiles/config/ranger/rifle.conf ~/.config/ranger/rifle.conf
    ln -s -f $HOME/dotfiles/config/ranger/rc.conf ~/.config/ranger/rc.conf
    ln -s -f $HOME/dotfiles/config/ranger/commands.py ~/.config/ranger/commands.py
    
    # install neovim plugins
    # (it's necessary to do this three times to ensure everything installs correctly)
    $HOME/.local/bin/nvim.appimage --headless +PlugInstall +qall
    $HOME/.local/bin/nvim.appimage --headless +PlugInstall +qall
    $HOME/.local/bin/nvim.appimage --headless +PlugInstall +qall

    # devicons2 for ranger
    if [ ! -d "$HOME/.config/ranger/plugins/devicons2" ]; then
        git clone https://github.com/cdump/ranger-devicons2 $HOME/.config/ranger/plugins/devicons2
    else
        echo ""
        echo -e "\033[0;35ranger devicons2 is already installed, skipping...\033[0m"
        echo ""
    fi

    # z.lua for ranger
    cp $HOME/.local/bin/z.lua-1.8.16/ranger_zlua.py $HOME/.config/ranger/plugins/
}

simple

echo ""
echo -e "\033[1;32mEverything is ready to go!\033[0m"
echo ""
