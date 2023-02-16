#!/bin/sh

if ! updates=$(checkupdates 2> /dev/null | wc -l ); then
    updates=0
fi

# updates greater equal than 1
if [ "$updates" -ge 1 ]; then
  echo "$updates Updates"
else
  echo "$updates Update"
fi
