#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1

setxkbmap us -variant intl-unicode -option caps:super && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &
dunst&
feh --bg-fill ~/.config/.wall.png

xsetroot -cursor_name left_ptr

emacs --daemon &
exec bspwm
