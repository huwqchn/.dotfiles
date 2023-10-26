#!/bin/bash

rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}' -icon-theme "Papirus" -show-icons -hover-select -me-select-entry '' -me-accept-entry MousePrimary -config ~/.config/rofi/clipmanager.rasi
