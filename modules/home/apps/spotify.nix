{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkMerge mkIf;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  inherit (config.home) homeDirectory;
  cfg = config.my.desktop.apps.spotify;
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  options.my.desktop.apps.spotify = {
    enable =
      mkEnableOption "Spotify"
      // {
        default = config.my.desktop.apps.enable;
      };
    spotify-player.enable =
      mkEnableOption "Spotify Player TUI"
      // {
        default = true;
      };
    spicetify.enable =
      mkEnableOption "Spicetify"
      // {
        default = config.my.desktop.apps.spotify.enable;
      };
  };

  config = mkMerge [
    (mkIf cfg.spicetify.enable {
      programs.spicetify = {
        enable = true;
        windowManagerPatch = isLinux;
      };
    })
    (mkIf cfg.spotify-player.enable {
      programs.spotify-player = {
        enable = true;
      };
      age.secrets.spotify-player = {
        rekeyFile = ./secrets/spotify-player.age;
        path = "${homeDirectory}/.cache/spotify-player/credentials.json";
        symlink = false;
      };
      home.persistence."/persist/${homeDirectory}" = {
        allowOther = true;
        directories = [".cache/spotify-player"];
      };
    })
  ];
}
