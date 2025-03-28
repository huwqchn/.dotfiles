{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr enum;
  inherit (lib.modules) mkDefault;
  cfg = config.my.desktop;
in {
  options.my.desktop.loginManager = mkOption {
    type = nullOr (enum [
      "greetd"
      "sddm"
      "cosmic-greeter"
    ]);
    description = "Desktop login manager.";
  };

  config = {
    my.desktop.loginManager = mkDefault (
      if cfg.enable
      then "greetd"
      else null
    );
  };
}
