#!/bin/sh

target=$(find ~/Documents/universidad/ingenieria-robotica/cuarto -name "*.pdf" | grep -v \
.stversions | awk ' 
function basename(file) {
	sub(".*cuarto/", "", file)
	return file
} {print(basename($0))} ' | rofi -dmenu -i -p "Elige un pdf")
if test -z "$target"
then
	echo "No pdf selected"
else
	zathura ~/Documents/universidad/ingenieria-robotica/cuarto/"$target"
fi
