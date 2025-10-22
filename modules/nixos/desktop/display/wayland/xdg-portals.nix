{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.modules) mkIf mkDefault;
  inherit (lib.my) isWayland;
  cfg = config.my.desktop;
  portal =
    if cfg.default == "hyprland"
    then "hyprland"
    else "wlr";
  enable = isWayland config;
in {
  config = mkIf enable {
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
        enable = mkDefault enable;
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
