{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf mkDefault;
  cfg = config.my.desktop;
  isWayland = cfg.type == "wayland";
  portal =
    if cfg.environment == "Hyprland"
    then "hyprland"
    else "wlr";
in {
  config = mkIf (cfg.enable && isWayland) {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
      ];
      config.common = {
        default = "*";

        # for flameshot to work
        # https://github.com/flameshot-org/flameshot/issues/3363#issuecomment-1753771427
        "org.freedesktop.impl.portal.Screencast" = ["${portal}"];
        "org.freedesktop.impl.portal.Screenshot" = ["${portal}"];
      };
      wlr = {
        enable = mkDefault isWayland;
        settings = {
          screencast = {
            max_fps = 60;
            chooser_type = "simple";
            chooser_cmd = "${getExe pkgs.slurp} -f %o -or";
          };
        };
      };
    };
  };
}
