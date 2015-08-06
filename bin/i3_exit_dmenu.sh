#!/bin/bash

# export $nb="#151515"
# export $nf="#999999"
# export $sb="#f00060"
# export $sf="#000000"
# export $fn="-*-*-medium-r-normal-*-*-*-*-*-*-100-*-*"

# -nb $nb  -nf $nf  -sb $sb  -sf $sf  -fn $fn

# hibernate doesn't seem to work on the Dell Inspiron
select=$( echo -e "SUSPEND\nREBOOT\nSHUTDOWN\nLOGOUT" | dmenu -l 5 -i -p  "Exit action to perform: ")

# Fuente
# http://askubuntu.com/questions/454039/what-command-is-executed-when-shutdown-from-the-graphical-menu-in-14-04

case "$select" in
    "SUSPEND") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Suspend" boolean:true ;;
    "HIBERNATE") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Hibernate" boolean:true ;;
    "REBOOT") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Reboot" boolean:true ;;
    "SHUTDOWN") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.PowerOff" boolean:true ;;
    "LOGOUT") i3-msg exit;;
esac;
