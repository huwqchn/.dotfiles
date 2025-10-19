{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption mkOption mkPackageOption;
  inherit (lib.types) path enum;
  inherit (lib.my) relativeToConfig;
in {
  options.my.keyboard = {
    # Note: I need to use general keyboard layout for my laptop and for Enterprise desktop
    layout = mkOption {
      type = enum ["qwerty" "colemak"];
      default = "colemak";
      description = "The keyboard layout to use";
    };

    kanata = {
      enable = mkEnableOption "Kanata keyboard remapping";

      package = mkPackageOption pkgs "kanata-with-cmd" {};

      configFile = mkOption {
        type = path;
        default = relativeToConfig "kanata/config.kbd";
        description = "Path to the primary Kanata configuration file.";
      };

      # tray.enable = mkEnableOption "kanata tray helper" // {default = cfg.enable;};
    };
  };
}
