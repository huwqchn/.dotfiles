#!/bin/bash

set_tmux_theme() {
	tmux_conf_dir=~/.config/tmux/conf
	if [ -z "${THEME}" ]; then
		theme="catppuccino"
	else
		theme="${THEME}"
	fi

	tmux source-file "${tmux_conf_dir}/themes/${theme}/theme.conf"

}

set_tmux_theme
