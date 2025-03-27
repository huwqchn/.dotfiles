{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.apps.obsidian;
in {
  options.my.apps.obsidian = {
    enable =
      mkEnableOption "Obsidian"
      // {
        default = config.my.apps.enable;
      };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # note taking
      obsidian
    ];
  };
}
