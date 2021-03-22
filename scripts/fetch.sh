#!/bin/bash

OS=$(hostnamectl | grep "Operating" | awk '{print $3}')
OSVER=$(hostnamectl | grep "Operating" | awk '{print $5}')
MODEL=$(cat /sys/devices/virtual/dmi/id/product_version)
VENDOR=$(cat /sys/devices/virtual/dmi/id/sys_vendor)
TERMINAL=$(echo $TERM | grep -oP '(?<=xterm-).*')

clear

echo " User: $(whoami)"
eco "Host: $(hostnamectl | grep "Static" | awk {'print $3'})"
echo "host: $(hostname -f)"
echo "OS: $OS $OSVER"
echo "Kernel: $(hostnamectl | grep "Kernel" | awk {'print $3'})"
echo "Shell: $SHELL $(bash --version | grep "GNU bash, version" | awk {'print $4'})"
echo "DM: $GDMSESSION"
echo "wm: $(xprop -id $(xprop -root -notype | awk '$1=="_NET_SUPPORTING_WM_CHECK:"{print $5}') | grep "NET_WM_NAME" | cut -d '"' -f2)"
echo "Editor: $EDITOR"
echo "CPU: $(lscpu | grep -oP "Model name:\K.*" | sed -e 's/^[ \t]*//')"
echo "RAM: $(free -m | grep "Mem:" | awk {'print $3'}) MiB / $(free -m | grep "Mem:" | awk {'print $2'}) MiB"
echo "pkgs: $(dpkg --list | wc --lines)"
echo "terminal: $TERMINAL"
echo "hardware: $VENDOR $MODEL"
