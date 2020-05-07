#!/bin/sh

# Variables
export _JAVA_AWT_WM_NONREPARENTING=1

# US keyboard with Latin variant
setxkbmap us -variant intl-unicode -option caps:super && killall xcape 2>/dev/null ; xcape -e 'Super_L=Escape' &

# Notifications
dunst &

# Wallpaper
feh --bg-fill ~/.config/.wall.png

# Show normal cursor
xsetroot -cursor_name left_ptr

# Hotkey daeomon
sxhkd &

# Window manager
exec bspwm
