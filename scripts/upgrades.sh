#!/bin/bash

num_upgrades=$(apt-get -s dist-upgrade | grep -Po "^[[:digit:]]+ (?=upgraded)" | sed -e 's/[[:space:]]*$//')

if (( $num_upgrades > 0 )); then
    echo "%{F#FABE3F}$num_upgrades%{F-}"
else
    echo "%{F#D4D4D4}$num_upgrades%{F-}"
fi
