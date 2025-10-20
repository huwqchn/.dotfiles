{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.my) withUWSM isHyprland;
  inherit (lib.types) enum nullOr str;
  inherit (lib.my) ldTernary scanPaths;
  inherit (config.my) browser;
in {
  imports = scanPaths ./.;

  options.my = {
    browser = {
      name = mkOption {
        type = nullOr str;
        default = null;
      };
      default = mkOption {
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
      exec = mkOption {
        type = str;
        default =
          if isHyprland config
          then withUWSM pkgs browser.default
          else getExe (builtins.getAttr browser.default pkgs);
        description = ''
          The command to use for the browser. This is used by the
          `my.browser` module to determine which command to run.
        '';
      };
    };
  };

  config = mkIf (browser.default != null) {
    home.sessionVariables = {BROWSER = "${browser.default}";};
  };
}
