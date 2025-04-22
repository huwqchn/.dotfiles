{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe';
  inherit (lib.my) withUWSM';
  isHyprland = config.my.desktop.environment == "hyprland";
  cfg = config.my.desktop.apps.zen;
  zenPkg = inputs.zen.packages.${pkgs.system}.default;
in {
  options.my.desktop.apps.zen = {
    enable =
      mkEnableOption "zen browser"
      // {
        default = config.my.browser == "zen";
      };
  };

  config = mkIf cfg.enable {
    my.commands.browser =
      if isHyprland
      then withUWSM' pkgs zenPkg "zen"
      else (getExe' zenPkg "zen");
    home = {
      packages = [zenPkg];

      persistence = {
        "/persist${config.home.homeDirectory}".directories = [".zen" ".cache/zen"];
      };
    };
  };
}
