{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop.hyprland;
in {
  options.my.desktop.hyprland.shade = {
    enable =
      mkEnableOption "hyprshade"
      // {
        default = cfg.enable;
      };
  };

  config = mkIf cfg.shade.enable {
    home.activation.hyprshade = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ${pkgs.hyprshade}/bin/hyprshade install
      ${pkgs.systemd}/bin/systemctl --user enable --now hyprshade.timer
    '';
    wayland.windowManager.hyprland.settings.exec = ["${pkgs.hyprshade}/bin/hyprshade auto"];
    xdg.configFile = {
      "hypr/hyprshade.toml".text = ''
        [[shades]]
        name = "vibrance"
        default = true

        [[shades]]
        name = "blue-light-filter"
        start_time = 19:00:00
        end_time = 06:00:00
      '';
    };
  };
}
