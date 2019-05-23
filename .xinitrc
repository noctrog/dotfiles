#!/bin/sh

wal --saturate 0.8 -a 80 -c -i ~/.config/wall.png -s -t
feh --bg-scale ~/.config/wall.png

setxkbmap -option caps:super -variant altgr-intl && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &

dunst &
xcompmgr &

exec dwm
