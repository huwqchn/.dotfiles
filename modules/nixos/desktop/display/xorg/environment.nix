{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.my) shell;
  cfg = config.my.desktop;
  inherit (cfg) environment;
  isXorg = cfg.type == "xorg";
in {
  config = mkIf (cfg.enable && isXorg) {
    environment.etc."greetd/environments".text =
      if config.services.greetd.enable
      then ''
        ${environment}
        ${shell}
      ''
      else "";
  };
}
