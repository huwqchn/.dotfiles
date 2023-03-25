#!/bin/bash
INPUT=$(rofi -dmenu -p " 󰚩  " -icon-theme "Papirus" -show-icons -config ~/.config/rofi/chatgpt.rasi)
if [[ -z $INPUT ]]; then
    exit 1
fi

zenity --progress --text="Waiting for an answer" --pulsate &

if [[ $? -eq 1 ]]; then
    exit 1
fi

PID=$!

ANSWER=$(~/.local/bin/sgpt "$INPUT" --no-animation --no-spinner)
kill $PID
zenity --info --text="$ANSWER"
