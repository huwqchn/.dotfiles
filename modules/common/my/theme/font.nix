{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) int;
in {
  options.my.theme.font = {
    sizes = {
      terminal = mkOption {
        type = int;
        default = 12;
        description = "The font size to use";
      };
    };
  };
}
