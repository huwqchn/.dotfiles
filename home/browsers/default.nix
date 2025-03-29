{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption mkIf;
  inherit (lib.types) enum nullOr;
  cfg = config.my.desktop.browser;
in {
  imports = lib.my.scanPaths ./.;
  options.my.desktop.browser = mkOption {
    type = nullOr (enum [
      "zen"
      "chrome"
    ]);
    default =
      if config.my.desktop.enable
      then "zen"
      else null;
    description = "The browser to use";
  };

  config = mkIf (cfg != null) {
    home.sessionVariable = {BROWSER = "${cfg}";};
  };
}
