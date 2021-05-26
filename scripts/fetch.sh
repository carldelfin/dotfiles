#!/bin/sh

user="$(whoami)"
host="$(hostname)"
os="$(lsb_release -ds)"
kernel="$(uname -r | sed 's/-.*//')"
terminal=$(echo $TERM | grep -oP '(?<=xterm-).*')
uptime="$(uptime -p | sed 's/up //')"
packages="$(dpkg -l | wc -l)"
shell=$(echo $SHELL | sed 's:.*/::')
ram_used=$(free -m | grep "Mem:" | awk {'print $3'}) 
ram_avail=$(free -m | grep "Mem:" | awk {'print $2'})
cpu="$(lscpu | grep -oP "Model name:\K.*" | awk {'print $2,$3,$4'})"

xpropid="$(xprop -root -notype | \awk '$1=="_NET_SUPPORTING_WM_CHECK:"{print $5}')"
wm="$(xprop -id "$xpropid" -notype -f _NET_WM_NAME 8t)"
wm=${wm/*_NET_WM_NAME = }
wm=${wm/\"}
wm=${wm/\"*}


RED='\033[0;31m'
YLW='\033[1;33m'
GRN='\033[1;32m'
CYN='\033[1;36m'
NC='\033[0m' # No Color

clear

echo -e "${YLW}user${NC}         $user"
echo -e "${YLW}host${NC}         $host"
echo -e "${YLW}os${NC}           $os"
echo -e "${YLW}kernel${NC}       $kernel"
echo -e "${YLW}wm${NC}           $wm"
echo -e "${YLW}terminal${NC}     $terminal"
echo -e "${YLW}shell${NC}        $shell"
echo -e "${YLW}packages${NC}       $packages"
echo -e "${YLW}memory${NC}       ${ram_used}M / ${ram_avail}M"
echo -e "${YLW}cpu${NC}          $cpu"
