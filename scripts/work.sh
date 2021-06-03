#!/bin/bash
#/usr/bin/nvim.appimage -o ~/Documents/work/projects/eeg_lha/manuscript.Rmd
bspc node -i
bspc node @/ -p east -i
bspc node @/2 -p north -i

bspc rule -a Zathura:zathura -o node=@/1
bspc rule -a Zathura:zathura -o node=@/2/1
bspc rule -a Zathura:zathura -o node=@/2/2
