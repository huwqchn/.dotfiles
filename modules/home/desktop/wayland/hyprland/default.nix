{
  pkgs,
  lib,
  config,
  # hyprland,
  # hyprland-plugins,
  ...
}: let
  package = pkgs.hyprland;
  cfg = config.my.desktop;
  inherit (lib.modules) mkIf;
in {
  imports = [./binds.nix ./rules.nix ./settings.nix];

  config = mkIf (cfg.enable && cfg.wayland.enable && pkgs.stdenv.hostPlatform.isLinux) {
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

    home = {
      packages = with pkgs; [
        playerctl
        avizo
        wireplumber
        brillo
        wl-clip-persist
        wl-clipboard-rs
        wl-screenrec
        wlr-randr
      ];

      # NOTE: this executable is used by greetd to start a wayland session when system boot up
      # with such a vendor-no-locking script, we can switch to another wayland compositor without modifying greetd's config in NixOS module
      file.".wayland-session" = {
        source = "${package}/bin/Hyprland";
        executable = true;
      };
    };

    # make stuff work on wayland
    # home.sessionVariables = {
    #   QT_QPA_PLATFORM = "wayland";
    #   SDL_VIDEODRIVER = "wayland";
    #   XDG_SESSION_TYPE = "wayland";
    # };
  };
}
