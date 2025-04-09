{
  config,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (config.my) shell;
  cfg = config.my.desktop;
in {
  config = mkIf (cfg.enable && cfg.xorg.enable) {
    environment.etc."greetd/environments".text =
      if config.services.greetd.enable
      then ''
        ${lib.optionalString (cfg.default == "i3") "i3"}
        ${lib.optionalString (cfg.default == "bspwm") "bspwm"}
        ${shell}
      ''
      else "";
  };
}
