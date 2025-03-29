{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.desktop.apps.browser;
in {
  options.my.desktop.apps.browser = {
    enable =
      mkEnableOption "zen"
      // {
        default = config.my.desktop.apps.enable;
      };
  };
  config = mkIf cfg.enable {
    home.packages = [inputs.zen.packages.${pkgs.system}.default];
    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".zen" ".cache/zen"];
    };
  };
}
