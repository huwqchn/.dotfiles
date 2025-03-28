{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.desktop.apps._1password;
in {
  options.my.desktop.apps._1password = {
    enable =
      mkEnableOption "1Password"
      // {
        default = config.my.desktop.apps.enable;
      };
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [_1password-cli _1password-gui];
  };
}
