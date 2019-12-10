#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1

setxkbmap -option caps:super && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &
feh --bg-fill ~/Pictures/Wallpapers/superintendent.png
slock

feh --bg-fill ~/.config/.wall.png
dunst&
feh --bg-fill ~/.config/.wall.png

xsetroot -cursor_name left_ptr

exec bspwm
