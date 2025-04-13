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
  inherit (pkgs.stdenv) system;
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
        default = config.my.desktop.enable;
      };
    spotify-player.enable =
      mkEnableOption "Spotify Player TUI"
      // {
        default = config.my.desktop.apps.spotify.enable;
      };
    spicetify.enable =
      mkEnableOption "Spicetify"
      // {
        default = config.my.desktop.apps.spotify.enable;
      };
  };

  config = mkMerge [
    (mkIf cfg.spicetify.enable {
      programs.spicetify = let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
      in {
        enable = true;
        windowManagerPatch = isLinux;
        enabledCustomApps = with spicePkgs.apps; [
          lyricsPlus
          reddit
          marketplace
          ncsVisualizer
          historyInSidebar
          betterLibrary
        ];
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          fullAppDisplay
          keyboardShortcut
          hidePodcasts
          songStats
          shuffle # shuffle+ (special characters are sanitized out of extension names)
          playlistIcons
          powerBar
        ];
      };
    })
    (mkIf cfg.spotify-player.enable {
      programs.spotify-player = {
        enable = true;
        actions = [
          {
            action = "ToggleLiked";
            key_sequence = "l";
          }
          {
            action = "AddToLibrary";
            key_sequence = "a";
          }
          {
            action = "Follow";
            key_sequence = "f";
          }
        ];
        keymaps = [
          {
            command = "NextTrack";
            key_sequence = "o";
          }
          {
            command = "PreviousTrack";
            key_sequence = "n";
          }
          {
            command = "SelectNextOrScrollDown";
            key_sequence = "e";
          }
          {
            command = "SelectPreviousOrScrollUp";
            key_sequence = "i";
          }
          {
            command = "MovePlaylistItemUp";
            key_sequence = "C-i";
          }
          {
            command = "MovePlaylistItemDown";
            key_sequence = "C-e";
          }
        ];
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
