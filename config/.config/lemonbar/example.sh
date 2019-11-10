#!/usr/bin/bash

source ~/.config/colors.sh
source ~/.config/lemonbar/modules.sh

export fg_a="#FF${foreground}"

export bg_a="#FF${background}"
export bg_b="#FF${color1}"

export main_bg="#4D${color0}"
export bg_select="#FF${color6}"

export con_bg="#FF${color4}"

export bg_alert="#FF${color3}"
export bg_warn="#FF${color1}" 
export bg_good="#FF${color2}" 

# Get the screen resolution
export screen_width=$(xrandr | grep current | awk '{print $10a}' | sed 's/,//g')
export bar_height=10


# Print status
while true; do
	echo \
		"%{l} $(System $fg_a $bg_a)" \
		"%{c}" \
		"%{r}" "$(Battery $fg_a $bg_a) $(Clock $fg_a $con_bg)"
	sleep 1s
done &
