{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkAfter;
  inherit (lib.my) withUWSM;
  cfg = config.my.desktop.hyprland;
  hyprnome' = withUWSM pkgs "hyprnome";
in {
  options.my.desktop.hyprland.nome = {
    enable =
      mkEnableOption "hyprnome"
      // {
        default = cfg.enable;
      };
  };
  config = mkIf cfg.nome.enable {
    home.packages = with pkgs; [
      hyprnome
    ];

    wayland.windowManager.hyprland .settings.bind = mkAfter [
      "$mod, mouse_down, exec, ${hyprnome'} --previous"
      "$mod, mouse_up, exec, ${hyprnome'}"
      "$mod, bracketleft, exec, ${hyprnome'} --previous"
      "$mod, bracketright, exec, ${hyprnome'}"
      "$mod SHIFT, bracketleft, exec, ${hyprnome'} --previous --move"
      "$mod SHIFT, bracketright, exec, ${hyprnome'} --move"
    ];
  };
}
