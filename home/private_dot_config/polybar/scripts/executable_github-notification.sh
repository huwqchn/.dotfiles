#!/bin/sh
USER="huwqchn@gmail.com"
# You can get your Personal access tokens from here : https://github.com/settings/tokens #
TOKEN=$(cat ~/.github-token)

notifications=$(echo "user = \"$USER:$TOKEN\"" | curl -sf -K- https://api.github.com/notifications | jq ".[].unread" | grep -c true)

# if [ "$notifications" -gt 0 ]; then
#   # echo "%{T3} $notifications"
#   echo "$notifications"
# fi
echo "$notifications"
