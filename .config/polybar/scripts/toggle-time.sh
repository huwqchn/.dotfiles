#!/bin/bash
t=0
sleep_pid=0

toggle() {
    t=$(((t + 1) % 2))

    if [ "$sleep_pid" -ne 0 ]; then
        kill $sleep_pid >/dev/null 2>&1
    fi
}


trap "toggle" USR1

while true; do
    if [ $t -eq 0 ]; then
        date
    else
        date --rfc-3339=seconds
    fi
    sleep 1 &
    sleep_pid=$!
    wait
done
# # Set the default time format to 12-hour
# time_format="%A, %d %B %Y"

# # Check if the time is currently displayed in 24-hour format
# if [ "$(date +"%I:%M %p")" == "$(date +"$time_format")" ]; then
#   # Set the time format to 24-hour
#   time_format="%I:%M %p"
# fi

# # Output the current time in the specified format
# date +"$time_format"
