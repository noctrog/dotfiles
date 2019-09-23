#!/bin/bash

target=$(find ~/Documents/Universidad/Ingenieria\ Robotica/Tercero -name "*.pdf" | dmenu -l 15 -i -p "Elige un pdf")
zathura "$target"
