#!/bin/bash

OPTION=$(echo -e "Power Off\nReboot\nSuspend" | dmenu -i -p "POWER" -nb black -sb orange -sf black)

case $OPTION in
    "Power Off" )
	systemctl poweroff;;
    "Suspend" )
	systemctl suspend;;
    "Reboot" )
	systemctl reboot;;
esac
