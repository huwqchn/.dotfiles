#!/bin/bash

# Set the default time format to 12-hour
time_format="%A, %d %B %Y"

# Check if the time is currently displayed in 24-hour format
if [ "$(date +"%I:%M %p")" == "$(date +"$time_format")" ]; then
  # Set the time format to 24-hour
  time_format="%I:%M %p"
fi

# Output the current time in the specified format
date +"$time_format"
