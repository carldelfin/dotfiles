#!/bin/sh

OS=$(hostnamectl | grep "Operating" | awk '{print $3}')
OSVER=$(hostnamectl | grep "Operating" | awk '{print $5}')
TERMINAL=$(echo $TERM | grep -oP '(?<=xterm-).*')
SH=$(echo $SHELL | sed 's:.*/::')

RED='\033[0;31m'
YLW='\033[1;33m'
GRN='\033[1;32m'
CYN='\033[1;36m'
NC='\033[0m' # No Color

clear

echo -e "${CYN}${NC} ${YLW}usr${NC}         $(whoami)"
echo -e " host        $(hostnamectl | grep "Static" | awk {'print $3'})"
echo -e " os          $OS $OSVER"
echo -e " kern        $(hostnamectl | grep "Kernel" | awk {'print $3'})"
echo -e " wm          $(xprop -id $(xprop -root -notype | awk '$1=="_NET_SUPPORTING_WM_CHECK:"{print $5}') | grep "NET_WM_NAME" | cut -d '"' -f2)"
echo -e " sh          $SH"
echo -e " term        $TERMINAL"
echo -e " ed          $EDITOR"
echo -e " cpu         $(lscpu | grep -oP "Model name:\K.*" | sed -e 's/^[ \t]*//')"
echo -e " ram         $(free -m | grep "Mem:" | awk {'print $3'}) MiB / $(free -m | grep "Mem:" | awk {'print $2'}) MiB"
