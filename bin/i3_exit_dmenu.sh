#!/bin/bash

# export $nb="#151515"
# export $nf="#999999"
# export $sb="#f00060"
# export $sf="#000000"
# export $fn="-*-*-medium-r-normal-*-*-*-*-*-*-100-*-*"

# -nb $nb  -nf $nf  -sb $sb  -sf $sf  -fn $fn

# para más opciones ver: https://github.com/ashinkarov/i3-extras/blob/master/i3-exit

select=$( echo -e "REBOOT\nSHUTDOWN\nLOGOUT" | dmenu -l 5 -i -p  "Exit action to perform: ")

case "$select" in
    "REBOOT") i3-nagbar -m "Selección: $select";;
    "SHUTDOWN") i3-nagbar -m "Selección: $select";;
    "LOGOUT") i3-nagbar -m "Selección: $select";;
esac;

# i3-nagbar -m "This would exit"
# i3-msg exit
