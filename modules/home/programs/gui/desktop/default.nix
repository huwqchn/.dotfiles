{lib, ...}: let
  inherit (lib.my) scanPaths;
  inherit (lib.options) mkOption;
  inherit (lib.types) int enum;
in {
  imports = scanPaths ./.;

  options.my.desktop.general = {
    workspace = {
      number = mkOption {
        type = int;
        default = 10;
        description = "Number of workspaces";
      };
    };
    keybind = {
      modifier = mkOption {
        type = enum ["SUPER" "CTRL" "ALT"];
        default = "SUPER";
        description = "Modifier key for keybinds";
      };
    };
  };
}
