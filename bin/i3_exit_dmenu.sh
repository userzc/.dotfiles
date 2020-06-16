#!/bin/bash

# colors from ~/.emacs.d/elpa/monokai-theme-20130703.1811/monokai-theme.el
# set $color_nf '#89BDFF'
color_nf='#66D9EF'
color_nb='#49483E'
# color_sf='#FD971F'
color_sf='#F92672'
color_sb='#171A0B'
bg_color='#2f343f'
# # So far I can't load the apropiarte fonts
fn='pango=:DejaVu Sans Mono 9'
fn1="System San Francisco Display 18"
# set $fn 'Meslo LG S for Powerline RegularForPowerline'

# screeen padding
screen_padding=$(($(xwininfo -root |awk '/Height/ { print $2}')/3))

message="Lock
Logout
Suspend
Reboot
Shutdown
Hibernate [-- CAUTION --]"

if [ $(uname) == 'Linux' ]; then
    if [ -n $(command -v lsb_release) ]; then
        os_type="$(lsb_release -si)"
        os_version="$(lsb_release -sr)"
    fi
fi

# hibernate doesn't seem to work on the Dell Inspiron
if [[ ( $(lsb_release -si) == "Ubuntu" ) && ( $(echo "$os_version > 16.04" | bc) == "1" ) || ( $(lsb_release -si) == "Debian" ) ]];  then
    select=$( echo -e "$message" | rofi -dmenu -i -p "[exit]" -sidebar-mode -config ~/.config/rofi/xdefaults-exit-config -padding "$screen_padding" -hide-scrollbar -font "$fn1")
elif [[ ( $(lsb_release -si) == "Ubuntu" ) && ( $(echo "$os_version <= 16.04" | bc) == "1" ) ]]; then
    select=$( echo -e "$message" | rofi -sidebar-mode -dmenu -i -p "[exit]" -width 100 -padding "$screen_padding" -hide-scrollbar -lines 6 -eh 2  -opacity "85" -bw 0 -bc "$bg_color" -bg "$color_nb" -fg "$color_nf" -hlbg "$color_sb" -hlfg "$color_sf" -hide-scroll-bar -font "$fn1")
fi

# Fuente
# http://askubuntu.com/questions/454039/what-command-is-executed-when-shutdown-from-the-graphical-menu-in-14-04
case "$select" in
    "Suspend") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Suspend" boolean:true ;;
    "Hibernate [-- CAUTION --]") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Hibernate" boolean:true ;;
    "Reboot") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.Reboot" boolean:true ;;
    "Shutdown") dbus-send --system --print-reply --dest=org.freedesktop.login1 /org/freedesktop/login1 "org.freedesktop.login1.Manager.PowerOff" boolean:true ;;
    "Lock") i3lock -c 000000 ;;
    "Logout") i3-msg exit;;
esac;

# Local Variables:
# eval: (rainbow-mode)
# End:
