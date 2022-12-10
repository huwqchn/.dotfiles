#!/bin/bash

# Set the default time format to 12-hour
date_format="%A, %d %B %Y"

current_date=$(date +"$date_format")

echo "$current_date"
