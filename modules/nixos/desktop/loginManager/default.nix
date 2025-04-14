{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr enum;
  inherit (lib.my) scanPaths;
  cfg = config.my.desktop;
in {
  imports = scanPaths ./.;

  options.my.desktop.loginManager = mkOption {
    type = nullOr (enum [
      "greetd"
      "sddm"
      "cosmic-greeter"
      "logind"
    ]);
    default =
      if cfg.enable
      then "greetd"
      else null;
    description = "Desktop login manager";
  };
}
