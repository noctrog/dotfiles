#!/bin/bash

target=$(find ~/Documents/Universidad/Ingenieria\ Robotica/Tercero -name "*.pdf" | grep -v .stversions | dmenu -l 15 -i -p "Elige un pdf")
if test -z "$target"
then
	echo "No pdf selected"
else
	zathura "$target"
fi
