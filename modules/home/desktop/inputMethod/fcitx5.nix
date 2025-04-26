{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.my) relativeToConfig;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  cfg = config.my.desktop.fcitx5;
in {
  options.my.desktop.fcitx5 = {
    enable =
      mkEnableOption "Enable fcitx5 input method"
      // {
        default = config.my.desktop.enable && isLinux;
      };
  };

  config = mkIf cfg.enable {
    xdg.configFile = {
      "fcitx5/profile" = {
        source = relativeToConfig "fcitx5/profile";
        force = true;
      };
      "fcitx5/config" = {
        source = relativeToConfig "fcitx5/config";
        force = true;
      };
    };
  };
}
