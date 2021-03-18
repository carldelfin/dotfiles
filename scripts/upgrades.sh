#!/bin/bash

num_upgrades=$(apt-get -s dist-upgrade | grep -Po "^[[:digit:]]+ (?=upgraded)" | sed -e 's/[[:space:]]*$//')

if (( $num_upgrades > 0 )); then
    echo "%{F#A0520B}$num_upgrades%{F-}"
else
    echo "%{F#D2D2D2}$num_upgrades%{F-}"
fi
