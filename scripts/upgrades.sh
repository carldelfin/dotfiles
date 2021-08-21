#!/bin/bash

num_upgrades=$(apt-get -s dist-upgrade | grep -Po "^[[:digit:]]+ (?=upgraded)" | sed -e 's/[[:space:]]*$//')

if (( $num_upgrades > 0 )); then
    echo "%{F#e0af68}$num_upgrades%{F-}"
else
    echo "%{F#c0caf5}$num_upgrades%{F-}"
fi
