#!/bin/bash
synclient TouchpadOff=$(synclient -l | grep -i -c 'touchpadoff.*=.*0')
if [ $(synclient -l | grep "TouchpadOff" | grep -Eo "[0-1]") = 0 ];
then
	notify-send -t 5000 "Touchpad" "On" -i touchpad-indicator-light-enabled && play /usr/share/sounds/freedesktop/stereo/bell.oga;
else
	notify-send -t 5000 "Touchpad" "Off" -i touchpad-indicator-light-disabled && play /usr/share/sounds/freedesktop/stereo/bell.oga;
fi
