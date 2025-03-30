{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.desktop.apps.zen;
in {
  options.my.desktop.apps.zen = {
    enable =
      mkEnableOption "zen browser"
      // {
        default = config.my.browser == "zen";
      };
  };

  config = mkIf cfg.enable {
    home.packages = [inputs.zen.packages.${pkgs.system}.default];
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".zen" ".cache/zen"];
    };
  };
}
