{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.my) withUWSM;
  inherit (lib.types) enum nullOr str;
  inherit (lib.my) ldTernary scanPaths;
  isHpyrland = config.my.desktop.environment == "hyprland";
  cfg = config.my.browser;
in {
  imports = scanPaths ./.;

  options.my = {
    commands.browser = mkOption {
      type = str;
      default =
        if isHpyrland
        then withUWSM pkgs cfg
        else getExe (builtins.getAttr cfg pkgs);
      description = ''
        The command to use for the browser. This is used by the
        `my.browser` module to determine which command to run.
      '';
    };
    browser = mkOption {
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
  };

  config = mkIf (cfg != null) {
    home.sessionVariables = {BROWSER = "${cfg}";};
  };
}
