#!/bin/sh

# enable correct mouse cursor
xsetroot -cursor_name left_ptr &

# terminate already running bar instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# which hwmon directory contains CPU temp?
if cat /proc/cpuinfo | grep "vendor" | uniq | grep -q "AMD"; then
  k10temp_dir=$(grep -lr "k10temp" /sys/class/hwmon/* -s | sed 's,/*[^/]\+/*$,,')
  export HWMON_DIR=$k10temp_dir/temp3_input # CCD1
else
  export HWMON_DIR="/sys/class/hwmon/hwmon0/temp1_input" # CCD1
fi

# launch polybar
polybar -c ~/dotfiles/config/polybar/polybar.conf cmd &

# terminate already running picom instances
killall -q picom

# wait until the processes have been shut down
while pgrep -u $UID -x picom >/dev/null; do sleep 1; done

# launch picom
picom --config ~/dotfiles/config/picom/picom.conf &

# set desktop background
feh --bg-scale ~/dotfiles/wallpaper/stairs.jpg &

# start syncthing
syncthing -no-browser
