#!/usr/bin/env bash

browser_wid=`xdotool search --name "Playwright"`
active_wid=`xdotool getactivewindow`
movement=("Page_Up" "Page_Down")

xdotool windowactivate $active_wid

echo "Entering infitine while"
i=0
while true
do
    sleep_sec="`shuf -i 8-15 -n 1`s"
    idx=`shuf -i 0-1 -n 1`
    echo "sleeping for $sleep_sec"
    echo "idx ${idx}"
    echo "moving ${movement[$idx]}"
    xdotool key "${movement[$idx]}"
    sleep $sleep_sec
done
