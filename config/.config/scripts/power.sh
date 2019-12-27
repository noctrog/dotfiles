#!/bin/bash

OPTION=$(echo -e "Power Off\nReboot\nSuspend\nHibernate" | dmenu -i -p "POWER")

case $OPTION in
    "Power Off" )
	systemctl poweroff;;
    "Suspend" )
	systemctl suspend;;
    "Reboot" )
	systemctl reboot;;
    "Hibernate" )
	systemctl hibernate;;
esac
