#!/bin/bash

OPTION=$(echo -e "Power Off\nReboot\nSuspend" | dmenu -i -p "POWER")

case $OPTION in
    "Power Off" )
	systemctl poweroff;;
    "Suspend" )
	systemctl suspend;;
    "Reboot" )
	systemctl reboot;;
esac
