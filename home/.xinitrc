#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1

feh --bg-fill ~/.config/.block.png
setxkbmap -option caps:super && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &

slock
dunst&
feh --bg-fill ~/.config/.wall.png

xsetroot -cursor_name left_ptr

emacs --daemon &
exec bspwm
