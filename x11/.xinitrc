#!/bin/sh

# If not set, Android Studio will not be able to render anything because of bloat
export _JAVA_AWT_WM_NONREPARENTING=1

# Keyboard remappings
rem

# Window manager
exec awesome
# exec startdwm
