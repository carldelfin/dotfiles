#!/bin/sh
#
#			 _               _   _       _             _     
#			| |             (_) | |     | |           | |    
#			| |__    _   _   _  | |   __| |      ___  | |__  
#			| '_ \  | | | | | | | |  / _` |     / __| | '_ \ 
#			| |_) | | |_| | | | | | | (_| |  _  \__ \ | | | |
#			|_.__/   \__,_| |_| |_|  \__,_| (_) |___/ |_| |_|
# 
#
# This scripts lets you select what applications to install, including and beyond the initial
# system setup. 
# 
# The script is based on previous work by Nathan Davieau, MestreLion, dols3m, and sergiofbsilva:
#
# https://serverfault.com/a/777849
# https://stackoverflow.com/a/54261882
# https://gist.github.com/sergiofbsilva/099172ea597657b0d0008dc367946953

# define colors
GREEN='\033[1;32m'
NC='\033[0m'

function prompt_for_multiselect {

    # helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()   { printf "$ESC[?25h"; }
    cursor_blink_off()  { printf "$ESC[?25l"; }
    cursor_to()         { printf "$ESC[$1;${2:-1}H"; }
    print_inactive()    { printf "$2   $1 "; }
    print_active()      { printf "$2  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()    { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()         {
      local key
      IFS= read -rsn1 key 2>/dev/null >&2
      if [[ $key = ""      ]]; then echo enter; fi;
      if [[ $key = $'\x20' ]]; then echo space; fi;
      if [[ $key = $'\x1b' ]]; then
        read -rsn2 key
        if [[ $key = [A ]]; then echo up;    fi;
        if [[ $key = [B ]]; then echo down;  fi;
      fi 
    }
    toggle_option()    {
      local arr_name=$1
      eval "local arr=(\"\${${arr_name}[@]}\")"
      local option=$2
      if [[ ${arr[option]} == true ]]; then
        arr[option]=
      else
        arr[option]=true
      fi
      eval $arr_name='("${arr[@]}")'
    }

    local retval=$1
    local options
    local defaults

    IFS=';' read -r -a options <<< "$2"
    if [[ -z $3 ]]; then
      defaults=()
    else
      IFS=';' read -r -a defaults <<< "$3"
    fi
    local selected=()

    for ((i=0; i<${#options[@]}; i++)); do
      selected+=("${defaults[i]:-false}")
      printf "\n"
    done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - ${#options[@]}))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local active=0
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for option in "${options[@]}"; do
            local prefix="[ ]"
            if [[ ${selected[idx]} == true ]]; then
              prefix="[${GREEN}x${NC}]"
            fi

            cursor_to $(($startrow + $idx))
            if [ $idx -eq $active ]; then
                print_active "$option" "$prefix"
            else
                print_inactive "$option" "$prefix"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            space)  toggle_option selected $active;;
            enter)  break;;
            up)     ((active--));
                    if [ $active -lt 0 ]; then active=$((${#options[@]} - 1)); fi;;
            down)   ((active++));
                    if [ $active -ge ${#options[@]} ]; then active=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    eval $retval='("${selected[@]}")'
}

# possible options
OPTIONS_VALUES=("Exit" "System setup" "Development setup" "Aleph setup" "Install R" "Install QMK" "Install Singularity" "Install Zotero" "Install TexLive")

for i in "${!OPTIONS_VALUES[@]}"; do
	OPTIONS_STRING+="${OPTIONS_VALUES[$i]};"
done

# define actions based on options
function ACTIONS {
    if [ "${SELECTED[0]}" == "true" ]; then
    	exit 1
    fi
    if [ "${SELECTED[1]}" == "true" ]; then
        source ~/dotfiles/build/system_setup.sh
    fi
    if [ "${SELECTED[2]}" == "true" ]; then
        source ~/dotfiles/build/dev_setup.sh
    fi
    if [ "${SELECTED[3]}" == "true" ]; then
        source ~/dotfiles/build/aleph_setup.sh
    fi
    if [ "${SELECTED[4]}" == "true" ]; then
        source ~/dotfiles/build/install_r.sh
    fi
    if [ "${SELECTED[5]}" == "true" ]; then
        source ~/dotfiles/build/install_qmk.sh
    fi
    if [ "${SELECTED[6]}" == "true" ]; then
        source ~/dotfiles/build/install_singularity.sh
    fi
    if [ "${SELECTED[7]}" == "true" ]; then
        source ~/dotfiles/build/install_zotero.sh
    fi
    if [ "${SELECTED[8]}" == "true" ]; then
        source ~/dotfiles/build/install_texlive.sh
    fi
}

clear

echo ""
echo "--------------------------------------------------"
echo " Navigate using arrows, select using SPACE"
echo " (press again to deselect), press ENTER when done "
echo "--------------------------------------------------"
echo ""

prompt_for_multiselect SELECTED "$OPTIONS_STRING"

ACTIONS
