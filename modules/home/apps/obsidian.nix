{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.desktop.apps.obsidian;
in {
  options.my.desktop.apps.obsidian = {
    enable =
      mkEnableOption "Obsidian"
      // {
        default = config.my.desktop.apps.enable;
      };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # note taking
      obsidian
    ];
  };
}
