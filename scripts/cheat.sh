#!/bin/sh

windowwidth=800
windowheight=600

screenwidth=$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $3}')
screenheight=$(xdpyinfo | awk -F'[ x]+' '/dimensions:/{print $4}')
windowx=$(("$screenwidth"/2-"$windowwidth"/2))
windowy=$(("$screenheight"/2-"$windowheight"/2))

bspc rule -a Zathura state=floating rectangle="$windowwidth"x"$windowheight"+"$windowx"+"$windowy"

zathura ~/dotfiles/cheatsheets/test.pdf
