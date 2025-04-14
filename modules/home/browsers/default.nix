{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.types) enum nullOr;
  inherit (lib.my) ldTernary scanPaths;
  cfg = config.my.browser;
in {
  imports = scanPaths ./.;

  options.my.browser = mkOption {
    type = nullOr (enum [
      "zen"
      "chrome"
    ]);
    default =
      if config.my.desktop.enable
      then ldTernary pkgs "zen" null
      else null;
    description = "The browser to use";
  };

  config = mkIf (cfg != null) {
    home.sessionVariables = {BROWSER = "${cfg}";};
  };
}
