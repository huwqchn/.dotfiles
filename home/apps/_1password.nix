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
    home.packages = with pkgs; [_1password-cli _1password-gui];
  };
}
