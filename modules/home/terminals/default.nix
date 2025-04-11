{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types) enum nullOr;
  cfg = config.my.terminal;
in {
  imports = lib.my.scanPaths ./.;
  options.my.terminal = mkOption {
    type = nullOr (enum [
      "wzeterm"
      "alacritty"
      "ghostty"
      "kitty"
    ]);
    default =
      if config.my.desktop.enable
      then "ghostty"
      else null;
    description = "The terminal to use";
  };

  config = mkIf (cfg != null) {
    home.sessionVariables = {TERMINAL = "${cfg}";};
  };
}
