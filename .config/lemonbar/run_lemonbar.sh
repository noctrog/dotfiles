#!/bin/sh

# Get the screen resolution
export screen_width=$(xrandr | grep current | awk '{print $8a}' | sed 's/,//g')
export bar_height=15
export text_size=14

~/.config/lemonbar/example.sh | lemonbar \
	-g ${screen_width}x${bar_height}+0+0 \
	-f "Roboto Medium:pixelsize=${text_size}" \
	-f "Font Awesome:pixelsize=${text_size}" \
	-f "Powerline" \
	| sh > /dev/null
