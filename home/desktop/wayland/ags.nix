{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.desktop;
in {
  imports = [inputs.ags.homeManagerModules.default];

  config = mkIf (cfg.enable && cfg.wayland.enable && pkgs.stdenv.isLinux) {
    home.packages = with pkgs; [
      bun
      dart-sass
      hyprpicker
      inputs.matugen.packages.${pkgs.system}.default
      swww
      brightnessctl
      slurp
      fortune
    ];
    programs.ags = {
      enable = true;
      configDir = lib.my.relativeToConfig "ags";
      extraPackages = with pkgs; [accountsservice];
    };

    home.persistence = {
      "/persist/${config.home.homeDirectory}".directories = [".cache/ags" ".local/share/com.github.Aylur.ags"];
    };
  };
}
