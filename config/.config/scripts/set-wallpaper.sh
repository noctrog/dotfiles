#!/bin/bash

#if hash wal -v 2>/dev/null; then
    #wal --saturate 0.8 -c -i ~/.config/wall.png -b 000000 && 
    feh --bg-fill ~/.config/.wall.png
    notify-send -i "$HOME/.config/.wall.png" "Wallpaper changed. ";
#else
    #if hash feh -v 2>/dev/null; then
	#feh --bg-scale "$HOME/.config/wall.png" &&
	#notify-send -i "$HOME/.config/wall.png" "Wallpaper changed. ";
    #fi
#fi
