{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.security;
in {
  config = mkIf cfg.enable {home.packages = with pkgs; [age sops rclone];};
}
