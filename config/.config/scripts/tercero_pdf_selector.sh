#!/bin/bash

target=$(find ~/Documents/universidad/ingenieria-robotica/tercero -name "*.pdf" | grep -v \
.stversions | awk ' 
function basename(file) {
	sub(".*tercero/", "", file)
	return file
} {print(basename($0))} ' | rofi -dmenu -i -p "Elige un pdf")
if test -z "$target"
then
	echo "No pdf selected"
else
	zathura ~/Documents/universidad/ingenieria-robotica/tercero/"$target"
fi
