#!/bin/bash

num_upgrades=$(apt-get -s dist-upgrade | grep -Po "^[[:digit:]]+ (?=upgraded)" | sed -e 's/[[:space:]]*$//')

if (( $num_upgrades > 0 )); then
    echo "%{F#EBCB8B}$num_upgrades%{F-}"
else
    echo "%{F#EBCB8B}$num_upgrades%{F-}"
fi
