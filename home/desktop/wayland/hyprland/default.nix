{
  pkgs,
  lib,
  config,
  # hyprland,
  # hyprland-plugins,
  ...
}: let
  package = pkgs.hyprland;
  cfg = config.my.desktop.wayland;
  inherit (lib) mkIf;
in {
  imports = [./binds.nix ./rules.nix ./settings.nix];

  config = mkIf (cfg.enable && pkgs.stdenv.isLinux) {
    home.packages = with pkgs; [
      playerctl
      avizo
      wireplumber
      brillo
      wl-clip-persist
      wl-clipboard-rs
      wl-screenrec
      wlr-randr
    ];

    # make stuff work on wayland
    # home.sessionVariables = {
    #   QT_QPA_PLATFORM = "wayland";
    #   SDL_VIDEODRIVER = "wayland";
    #   XDG_SESSION_TYPE = "wayland";
    # };

    # enable hyprland
    wayland.windowManager.hyprland = {
      enable = true;
      inherit package;
      xwayland.enable = true;

      # plugins = with hyprland-plugins.packages.${pkgs.system}; [
      #   hyprbars
      #   hyprexpo
      # ];

      systemd = {
        enable = true;
        variables = ["--all"];
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
    };

    # NOTE: this executable is used by greetd to start a wayland session when system boot up
    # with such a vendor-no-locking script, we can switch to another wayland compositor without modifying greetd's config in NixOS module
    home.file.".wayland-session" = {
      source = "${package}/bin/Hyprland";
      executable = true;
    };
  };
}
