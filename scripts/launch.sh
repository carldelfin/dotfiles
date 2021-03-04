#!/bin/bash

# terminate already running bar instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# which hwmon directory contains k10temp?
k10temp_dir=$(grep -lr "k10temp" /sys/class/hwmon/* -s | sed 's,/*[^/]\+/*$,,')
export HWMON_DIR=$k10temp_dir/temp3_input # CCD1

# launch polybar
polybar -c ~/dotfiles/config/polybar/config cmd &
