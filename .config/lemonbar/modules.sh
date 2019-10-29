#!/bin/bash

# My modules for lemonbar
# Each module asks for two arguments:
#	- $1: Foreground color
#	- $2: Background color

# System
System() {
	NAME=$(uname)
	echo -n -e "%{F$1}%{B$2} $NAME %{F-}%{B-}"
}

# Define the clock
Clock() {
        DATETIME=$(date "+%H:%M")
	echo -n -e "%{F$1}%{B$2} $DATETIME %{F-}%{B-}"
}

# Battery percentage
Battery() {
	BAT_CHARGE=$(acpi -b | cut -d, -f2)
	echo -n -e "%{F$1}%{B$2} \uf5df $BAT_CHARGE %{F-}%{B-}"
}
