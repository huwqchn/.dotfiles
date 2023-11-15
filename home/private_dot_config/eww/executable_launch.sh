#!/bin/bash

## Run eww daemon if not running already
if [[ ! $(pidof eww) ]]; then
	eww daemon
	sleep 1
fi

## Open widgets
run_eww() {
	eww open-many \
		bar \
		conky-right-top \
		conky-left-bottom
}

run_eww && bspc config top_padding 63 && bspc config top_monocle_padding 12
