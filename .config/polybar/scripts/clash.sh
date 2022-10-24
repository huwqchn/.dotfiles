#!/bin/sh


if [ ! -z "$(systemctl status docker | grep inactive)" ]; then
	echo "%{F} "
elif [ -z "$(docker ps -a | grep clash | grep Up)" ]; then
	echo "%{F#e0af68} "
else
	echo "%{F#7aa2f7} "
fi
