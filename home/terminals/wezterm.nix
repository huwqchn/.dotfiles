{
  mylib,
  config,
  ...
}: {
  home.sessionVariables = {TERMINAL = "wezterm";};
  programs.wezterm = {
    enable = true;
  };
  xdg.configFile."wezterm" = {
    recursive = true;
    source = mylib.relativeToConfig "wezterm";
  };
  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [
      ".cache/wezterm"
      ".local/share/wezterm"
    ];
  };
}
