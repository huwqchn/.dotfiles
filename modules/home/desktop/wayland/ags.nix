{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop;
  isWayland = cfg.type == "wayland";
in {
  imports = [inputs.ags.homeManagerModules.default];

  config = mkIf (cfg.enable && isWayland) {
    programs.ags = {
      enable = true;
      configDir = lib.my.relativeToConfig "ags";
      extraPackages = with pkgs; [accountsservice];
    };

    home = {
      packages = with pkgs; [
        bun
        dart-sass
        hyprpicker
        inputs.matugen.packages.${pkgs.system}.default
        swww
        brightnessctl
        slurp
        fortune
      ];

      persistence."/persist/${config.home.homeDirectory}".directories = [
        ".cache/ags"
        ".local/share/com.github.Aylur.ags"
      ];
    };
  };
}
