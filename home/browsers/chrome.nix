{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.chrome;
in {
  options.my.chrome = {enable = mkEnableOption "chrome";};
  config = mkIf cfg.enable {
    home.packages = with pkgs; [google-chrome];

    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".config/google-chrome"];
    };
  };
}
