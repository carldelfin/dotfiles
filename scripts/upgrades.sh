#!/bin/bash

num_upgrades=$(apt-get -s dist-upgrade | grep -Po "^[[:digit:]]+ (?=upgraded)" | sed -e 's/[[:space:]]*$//')

if (( $num_upgrades > 0 )); then
    echo "%{F#FBB86C}$num_upgrades%{F-}"
else
    echo "%{F#CCCCCC}$num_upgrades%{F-}"
fi