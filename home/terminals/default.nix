{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) enum nullOr;
  inherit (lib.my) ldTernary;
  cfg = config.my.desktop.terminal;
in {
  imports = lib.my.scanPaths ./.;
  options.my.desktop.terminal = mkOption {
    type = nullOr (enum [
      "wzeterm"
      "alacritty"
      "ghostty"
      "kitty"
    ]);
    default =
      if config.my.desktop.enable
      then ldTernary pkgs "ghostty" null
      else null;
    description = "The terminal to use";
  };

  config = mkIf (cfg != null) {
    home.sessionVariables = {TERMINAL = "${cfg}";};
  };
}
