#!/bin/bash

target=$(find ~/Documents/Libros -name "*.pdf" -o -name "*.epub" -o -name "*.djvu" | grep -v .stversions | awk '
function basename(file) {
	sub(".*Libros/", "", file)
	return file
} {print basename( $0 )} ' - | dmenu -l 15 -i -p "Elige un libro:")

if test -z "$target"
then
	echo "No book selected"
else
	zathura ~/Documents/Libros/"$target"
fi
