{
  hyprland-plugins,
  pkgs,
  ...
}:
{
  improts = [
    ./settings.nix
    ./rules.nix
    ./binds.nix
  ];
  home.packages = with pkgs; [
    playerctl
    avizo
    wireplumber
    brillo
    wl-clip-persist
    wl-clipboard-rs
    wl-screenrec
    wlr-randr
  ];

  # make stuff work on wayland
  # home.sessionVariables = {
  #   QT_QPA_PLATFORM = "wayland";
  #   SDL_VIDEODRIVER = "wayland";
  #   XDG_SESSION_TYPE = "wayland";
  # };

  # enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = with hyprland-plugins.packages.${pkgs.system}; [
      hyprbars
      hyprexpo
    ];

    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
