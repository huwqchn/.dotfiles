{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.apps;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # instant messaging
      telegram-desktop
      discord

      # note taking
      obsidian
    ];
  };
}
