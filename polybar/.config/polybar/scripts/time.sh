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
  #Get the current time
  time=$(date "+%I:%M %p")
  time_alt=$(date "+%A, %d %B %Y")
  # Get the hour of the day
  hour=$(date +"%I")

  # Set the clock icon to use
  if [ "$hour" -eq 1 ]; then
    clock_icon="%{T2} %{T-}"
  elif [ "$hour" -eq 2 ]; then
    clock_icon="%{T2} %{T-}"
  elif [ "$hour" -eq 3 ]; then
    clock_icon="%{T2} %{T-}"
  elif [ "$hour" -eq 4 ]; then
    clock_icon="%{T2} %{T-}"
  elif [ "$hour" -eq 5 ]; then
    clock_icon="%{T2} %{T-}"
  elif [ "$hour" -eq 6 ]; then
    clock_icon="%{T2} %{T-}"
  elif [ "$hour" -eq 7 ]; then
    clock_icon="%{T2} %{T-}"
  elif [ "$hour" -eq 8 ]; then
    clock_icon="%{T2} %{T-}"
  elif [ "$hour" -eq 9 ]; then
    clock_icon="%{T2} %{T-}"
  elif [ "$hour" -eq 10 ]; then
    clock_icon="%{T2} %{T-}"
  elif [ "$hour" -eq 11 ]; then
    clock_icon="%{T2} %{T-}"
  else
    clock_icon="%{T2} %{T-}"
  fi
  if [ $t -eq 0 ]; then
    echo -e "$clock_icon%{T4}$time%{T-}"
  else
    echo -e "$clock_icon%{T4}$time_alt%{T-}"
  fi
  sleep 1 &
  sleep_pid=$!
  wait
done
