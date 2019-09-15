#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1

feh --bg-fill ~/.config/wall.png
setxkbmap -option caps:super -variant altgr-intl && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &
#slock

dunst &
compton&
slstatus &
redshift&

exec awesome
