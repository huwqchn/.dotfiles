#!/bin/bash

if pgrep -x "stalonetray" > /dev/null
then
    killall stalonetray
    # echo "" > $HOME/.config/polybar/scripts/tray-status
    echo "" > $HOME/.config/polybar/scripts/tray-status
else
    stalonetray &
    # echo "" > $HOME/.config/polybar/scripts/tray-status
    echo "" > $HOME/.config/polybar/scripts/tray-status
fi
