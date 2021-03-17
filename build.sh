#!/bin/bash

# ==============================================================================
#
# This script makes it possible to select what to install from my dotfiles
#
# It's based on work by dols3m and sergiofbsilva from
# https://stackoverflow.com/a/54261882/317605
# and
# https://stackoverflow.com/users/8207842/dols3m
#
# ==============================================================================


# define colors
GREEN='\033[1;32m'
RED='\033[0;31m'
NC='\033[0m'

# define menu options
options[0]="${RED}Abort${NC}"
options[1]="System setup"
options[2]="Install R and Radian"
options[4]="Install Zotero"
options[5]="Install TexLive"
options[6]="Install Zoom"

# define actions based on options
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        exit 1
    fi
    if [[ ${choices[1]} ]]; then
        source ~/dotfiles/build/system_setup.sh
    fi
    if [[ ${choices[2]} ]]; then
        source ~/dotfiles/build/install_r.sh
    fi
    if [[ ${choices[4]} ]]; then
        source ~/dotfiles/build/04_install_zotero.sh
    fi
    if [[ ${choices[5]} ]]; then
        source ~/dotfiles/build/05_install_texlive.sh
    fi
    if [[ ${choices[6]} ]]; then
        source ~/dotfiles/build/06_install_zoom.sh
    fi
}

ERROR=" "

clear

# menu function
function MENU {
    echo ""
    echo "---------------------------------------------------------------------"
    for NUM in ${!options[@]}; do
        echo -e $(( NUM+1 ))" "[""${GREEN}${choices[NUM]:- }"${NC}"]" ${options[NUM]}"
    done
    echo "---------------------------------------------------------------------"
    echo "$ERROR"
}

# menu loop
while MENU && read -e -p "Select by pressing the corresponding number (press again to deselect), then ENTER when done: " -n2 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS
