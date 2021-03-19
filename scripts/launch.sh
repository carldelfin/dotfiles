#!/bin/bash

# terminate already running bar instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# which hwmon directory contains CPU temp?
if cat /proc/cpuinfo | grep "vendor" | uniq | grep -q "AMD"; then
  k10temp_dir=$(grep -lr "k10temp" /sys/class/hwmon/* -s | sed 's,/*[^/]\+/*$,,')
  export HWMON_DIR=$k10temp_dir/temp3_input # CCD1
else
  export HWMON_DIR="/sys/class/hwmon/hwmon0/temp1_input"# CCD1
fi

# launch polybar
polybar -c ~/dotfiles/config/polybar/polybar.conf cmd &

# launch picom
picom --config ~/dotfiles/config/picom/picom.conf &

# set desktop background
hsetroot -solid "#1B1D22"

# enable sound
pulseaudio --start

# start syncthing
syncthing -no-browser

# set correct mouse cursor
xsetroot -cursor_name left_ptr
