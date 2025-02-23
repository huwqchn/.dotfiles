{
  config,
  pkgs,
  lib,
  zen-browser,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.zen;
in {
  options.my.zen = {enable = mkEnableOption "zen";};
  config = mkIf cfg.enable {
    home.packages = [zen-browser.packages.${pkgs.system}.default];
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".zen" ".cache/zen"];
    };
  };
}
