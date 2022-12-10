#!/bin/bash

#Get the current time
time=$(date "+%I:%M %p")

# Get the hour of the day
hour=$(date +"%I")

# Set the clock icon to use
if [ "$hour" -eq 1 ]; then
  clock_icon="%{T3} %{T-}"
elif [ "$hour" -eq 2 ]; then
  clock_icon="%{T3} %{T-}"
elif [ "$hour" -eq 3 ]; then
  clock_icon="%{T3} %{T-}"
elif [ "$hour" -eq 4 ]; then
  clock_icon="%{T3} %{T-}"
elif [ "$hour" -eq 5 ]; then
  clock_icon="%{T3} %{T-}"
elif [ "$hour" -eq 6 ]; then
  clock_icon="%{T3} %{T-}"
elif [ "$hour" -eq 7 ]; then
  clock_icon="%{T3} %{T-}"
elif [ "$hour" -eq 8 ]; then
  clock_icon="%{T3} %{T-}"
elif [ "$hour" -eq 9 ]; then
  clock_icon="%{T3} %{T-}"
elif [ "$hour" -eq 10 ]; then
  clock_icon="%{T3} %{T-}"
elif [ "$hour" -eq 11 ]; then
  clock_icon="%{T3} %{T-}"
else
  clock_icon="%{T3} %{T-}"
fi

# Output the clock icon and the current time
echo -e "$clock_icon$time"
