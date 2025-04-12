{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.my.desktop.apps.mpv;
in {
  options.my.desktop.apps.mpv = {
    enable =
      mkEnableOption "support for mpv"
      // {
        default = config.my.desktop.enable;
      };
  };

  config = mkIf cfg.enable {
    programs.mpv = {
      enable = pkgs.stdenv.hostPlatform.isLinux;
      package = pkgs.mpv;

      defaultProfiles = ["gpu-hq"];
      scripts = lib.optionals pkgs.stdenv.hostPlatform.isLinux [pkgs.mpvScripts.mpris];
    };

    services.plex-mpv-shim.enable = pkgs.stdenv.hostPlatform.isLinux;
  };
}
