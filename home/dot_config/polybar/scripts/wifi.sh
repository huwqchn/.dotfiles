#!/bin/bash

ssid=$(iwgetid -r)

if [[ "$ssid" == "" ]]; then
  echo "睊 disconnected"

else
  echo "直 $ssid"
fi
