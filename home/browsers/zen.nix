{
  config,
  pkgs,
  lib,
  zen,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.zen;
in {
  options.my.zen = {enable = mkEnableOption "zen";};
  config = mkIf cfg.enable {
    home.packages = [zen.packages.${pkgs.system}.default];
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".zen" ".cache/zen"];
    };
  };
}
