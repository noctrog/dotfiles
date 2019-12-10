#!/bin/bash

target=$(find ~/Documents/Universidad/Ingenieria\ Robotica/Tercero -name "*.pdf" | grep -v \
.stversions | awk ' 
function basename(file) {
	sub(".*Tercero/", "", file)
	return file
} {print(basename($0))} ' | rofi -dmenu -i -p "Elige un pdf")
if test -z "$target"
then
	echo "No pdf selected"
else
	zathura ~/Documents/Universidad/Ingenieria\ Robotica/Tercero/"$target"
fi
