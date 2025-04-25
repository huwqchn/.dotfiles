{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.my) toggle' isWayland;
  enable = config.my.desktop.launcher == "anyrun" && isWayland config;
  pkg = inputs.anyrun.packages.${pkgs.system};
  anyrunPkg = pkg.anyrun-with-all-plugins;
  anyrun' = toggle' pkgs anyrunPkg "anyrun";
in {
  config = mkIf enable {
    wayland.windowManager.hyprland.settings = {
      bindr = [
        # launcher
        "$mod, SPACE, exec, ${anyrun'}"
      ];
    };
    programs.anyrun = {
      enable = true;
      package = anyrunPkg;

      config = {
        plugins = with pkg; [
          # An array of all the plugins you want, which either can be paths to the .so files, or their packages
          applications
          stdin
          applications
          dictionary
          kidex
          randr
          rink
          shell
          stdin
          symbols
          translate
          websearch
        ];
        width.fraction = 0.25;
        y.fraction = 0.3;
        hidePluginInfo = true;
        closeOnClick = true;
      };

      extraConfigFiles = {
        "uwsm_app.ron".text = ''
          Config(
            desktop_actions: false,
            max_entries: 5,
          )
        '';

        "shell.ron".text = ''
          Config(
            prefix: ">"
          )
        '';

        "randr.ron".text = ''
          Config(
            prefi: ":dp",
            max_entries: 5,
          )
        '';
      };
    };
  };
}
