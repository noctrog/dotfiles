#!/bin/bash

target=$(find ~/Documents/libros -name "*.pdf" -o -name "*.epub" -o -name "*.djvu" | grep -v .stversions | awk '
function basename(file) {
	sub(".*libros/", "", file)
	return file
} {print basename( $0 )} ' - | rofi -dmenu -i -p "Elige un libro")
#} {print basename( $0 )} ' - | dmenu -l 15 -i -p "Elige un libro:")

if test -z "$target"
then
	echo "No book selected"
else
	zathura ~/Documents/libros/"$target"
fi
