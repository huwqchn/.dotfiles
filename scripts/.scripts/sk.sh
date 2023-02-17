result=$(ps ax|grep -v grep|grep screenkey)
if [ "$result" == "" ]; then
  eval "screenkey --opacity 0.0 --bg-color black --font-color white &"
else
  eval "killall screenkey"
fi
