#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1

feh --bg-fill ~/Pictures/Wallpapers/Reach.png
setxkbmap -option caps:super -variant altgr-intl && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &
#slock

#compton&
dunst&
redshift&

#exec awesome
exec bspwm
