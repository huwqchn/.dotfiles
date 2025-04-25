{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.my) withUWSM relativeToConfig;
  cfg = config.home.desktop.fcitx5;
  fcitx5' = withUWSM pkgs "fcitx5";
in {
  options.my.desktop.fcitx5 = {
    enable = mkEnableOption "Enable fcitx5 input method";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings.exec-once = [
      fcitx5'
    ];
    xdg.configFile.fcitx5.config = relativeToConfig "fcitx5";
  };
}
