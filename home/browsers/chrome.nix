{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.desktop.apps.chrome;
in {
  options.my.desktop.apps.chrome = {
    enable =
      mkEnableOption "chrome"
      // {
        default = config.my.desktop.browser == "chrome";
      };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [google-chrome];
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".config/google-chrome"];
    };
  };
}
