#!/bin/sh

CLASH=$(docker ps -a | grep clash | grep Up)

if [ -z "$CLASH" ]; then
	# echo "%{F}  "
	echo "%{F#e0af68}  "
else
	echo "%{F#449dab}  "
fi
