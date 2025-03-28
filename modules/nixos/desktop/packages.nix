{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.desktop.apps;
in {
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      veracrypt # a free disk encryption software
    ];
  };
}
