{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.desktop.hyprland;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      hyprpicker
      (writeShellScriptBin "hyprpicker-wl-copy" ''
        ${hyprpicker}/bin/hyprpicker \
        | tee >(${wl-clipboard}/bin/wl-copy) \
        >(${libnotify}/bin/notify-send "Color picked" "$(cat)") \
        >/dev/null
      '')
    ];
  };
}
