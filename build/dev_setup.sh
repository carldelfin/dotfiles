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
        echo -e "\033[0;35vim-plug found, skipping...\033[0m"
    else
        sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    fi

    # install neovim plugins
    $HOME/.local/bin/nvim.appimage --headless +PlugInstall +qall

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

    # lf
    if [ -f "$HOME/.local/bin/lf" ]; then
        echo -e "\033[0;35mlf executable found, skipping...\033[0m"
    else
        cd $HOME/.local/bin
        wget https://github.com/gokcehan/lf/releases/download/r28/lf-linux-amd64.tar.gz
        tar -xf *.tar.gz
        rm *tar.gz
        cd
    fi

    # fzf
    if [ -f "$HOME/.local/bin/lf" ]; then
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
    mkdir -p $HOME/.config/{nvim,lf}
    
    # append to .bashrc
    cat $HOME/dotfiles/config/bash/bashrc_additions >> $HOME/.bashrc
    
    # symlink configs
    ln -s -f ~/dotfiles/config/nvim/* ~/.config/nvim/
    ln -s -f ~/dotfiles/config/lf/* ~/.config/lf/
   
}

simple

echo ""
echo -e "\033[1;32mEverything is ready to go!\033[0m"
echo ""
