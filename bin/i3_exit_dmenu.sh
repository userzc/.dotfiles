#!/bin/bash

# export $nb="#151515"
# export $nf="#999999"
# export $sb="#f00060"
# export $sf="#000000"
# export $fn="-*-*-medium-r-normal-*-*-*-*-*-*-100-*-*"

# colors from ~/.emacs.d/elpa/monokai-theme-20130703.1811/monokai-theme.el
# set $color_nf '#89BDFF'
color_nf='#66D9EF'
color_nb='#49483E'
# color_sf='#FD971F'
color_sf='#F92672'
color_sb='#171A0B'
bg-color='#2f343f'
# # So far I can't load the apropiarte fonts
fn='pango=:DejaVu Sans Mono 9'
# set $fn 'Meslo LG S for Powerline RegularForPowerline'

# -nb $nb  -nf $nf  -sb $sb  -sf $sf  -fn $fn
message="Suspend
Hibernate [-- CAUTION --]
Reboot
Shutdown
Lock
Logout"

# hibernate doesn't seem to work on the Dell Inspiron
# select=$( echo -e "$message" | dmenu -l 5 -i -p  "Exit action to perform: ")
select=$( echo -e "$message" | rofi -sidebar-mode -dmenu -i -p "[exit]:" -width 100 -padding 50 -hide-scrollbar -lines 5 -eh 2  -opacity "85" -bw 0 -bc "$bg-color" -bg "$color_nb" -fg "$color_nf" -hlbg "$color_sb" -hlfg "$color_sf" -hide-scroll-bar -font "System San Francisco Display 18")

# Fuente
# http://askubuntu.com/questions/454039/what-command-is-executed-when-shutdown-from-the-graphical-menu-in-14-04

case "$select" in
    "Suspend") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Suspend" boolean:true ;;
    "Hibernate [-- CAUTION --]") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Hibernate" boolean:true ;;
    "Reboot") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Reboot" boolean:true ;;
    "Shutdown") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.PowerOff" boolean:true ;;
    "Lock") i3lock;;
    "Logout") i3-msg exit;;
esac;
