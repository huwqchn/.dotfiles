rofi -dmenu -p "  Search:" -icon-theme "Papirus" -show-icons -config ~/.config/rofi/search.rasi | xargs -I{} xdg-open https://www.google.de/search?q={}
