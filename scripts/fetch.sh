#!/bin/sh

user="$(whoami)"
host="$(hostname)"
os="$(lsb_release -ds)"
kernel="$(uname -r | sed 's/-.*//')"

xpropid="$(xprop -root -notype | \awk '$1=="_NET_SUPPORTING_WM_CHECK:"{print $5}')"
wm="$(xprop -id "$xpropid" -notype -f _NET_WM_NAME 8t)"
wm=${wm/*_NET_WM_NAME = }
wm=${wm/\"}
wm=${wm/\"*}

terminal=$(echo $TERM | grep -oP '(?<=xterm-).*')
shell=$(echo $SHELL | sed 's:.*/::')
packages="$(dpkg -l | wc -l)"

ram_used=$(free -m | grep "Mem:" | awk {'print $3'}) 
ram_avail=$(free -m | grep "Mem:" | awk {'print $2'})

cpu="$(lscpu | grep -oP "Model name:\K.*" | awk {'print $2,$3,$4'})"

YLW='\033[1;33m'
NC='\033[0m' 

echo ""
echo -e " ${YLW}user${NC}         $user"
echo -e " ${YLW}host${NC}         $host"
echo -e " ${YLW}os${NC}           $os"
echo -e " ${YLW}kernel${NC}       $kernel"
echo -e " ${YLW}wm${NC}           $wm"
echo -e " ${YLW}terminal${NC}     $terminal"
echo -e " ${YLW}shell${NC}        $shell"
echo -e " ${YLW}packages${NC}     $packages"
echo -e " ${YLW}cpu${NC}          $cpu"
echo -e " ${YLW}memory${NC}       ${ram_used}M / ${ram_avail}M"
echo ""
