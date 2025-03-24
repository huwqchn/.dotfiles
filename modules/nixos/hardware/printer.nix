{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.my.machine) hasPrinter;
in {
  options.my.machine.hasPrinter = mkEnableOption "Whether has printer support";

  config = mkIf hasPrinter {
    services.printing = {
      enable = true;
      startWhenNeeded = true;
      # logLevel = "debug";
    };
  };
}
