{ mylib, ... }: {
  programs.wezterm = {
    enable = true;
  };
  xdg.configFile."wezterm" = {
    recursive = true;
    source = mylib.relativeToConfig "wezterm";
  };
}
