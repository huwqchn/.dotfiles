{ lib, config, ... }: let
  cfg = config.my.desktop;
  inherit (lib) mkIf;
in {
  config = mkIf cfg.enable {
    services.dbus = {
      enable = true;
      # Use the faster dbus-broker instead of the classic dbus-daemon
      implementation = "broker";

      packages = builtins.attrValues { inherit (pkgs) dconf gcr udisks2; };
    };
  };
}
