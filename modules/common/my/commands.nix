{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (lib.options) mkOption;
  inherit (lib.types) str;
  inherit (config.my.desktop) environment;
in {
  options.my.commands = {
    login = mkOption {
      type = str;
      default = getExe (builtins.getAttr environment pkgs);
      description = ''
        The command to use for logging in. This is used by the
        `my.login` module to determine which command to run.
      '';
    };
  };
}
