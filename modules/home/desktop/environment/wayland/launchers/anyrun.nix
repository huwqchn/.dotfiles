{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.my) toggle;
  enable = config.my.desktop.launcher == "anyrun";
  anyrunPkg = inputs.anyrun.packages.${pkgs.system}.anyrun-with-all-plugins;
  anyrun' = getExe anyrunPkg;
in {
  config = mkIf enable {
    wayland.windowManager.hyprland.settings = {
      bindr = [
        # launcher
        "$mod, SPACE, exec, ${toggle anyrun'}"
      ];
    };
    programs.anyrun = {
      enable = true;
      package = anyrunPkg;

      config = {
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
