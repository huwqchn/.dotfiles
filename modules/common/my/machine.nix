{lib, ...}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) enum str nullOr listOf;
in {
  # hardware
  options.my.machine = {
    type = mkOption {
      type = enum ["workstation" "server" "laptop" "desktop" "mobile" "vm" "wsl"];
      default = "laptop";
      description = "The architecture of the system";
    };
    gpu = mkOption {
      type = nullOr (
        enum [
          "intel"
          "nvidia"
          "amd"
          "hybrid-nv"
        ]
      );
      default = null;
      description = "The GPU of the system";
    };
    cpu = mkOption {
      type = nullOr (
        enum [
          "intel"
          "amd"
          "vm-intel"
          "vm-amd"
        ]
      );
      default = null;
      description = "The CPU of the system";
    };
    monitors = mkOption {
      type = listOf str;
      default = [];
      description = ''
        this does not affect any drivers and such, it is only necessary for
        declaring things like monitors in window manager configurations
        you can avoid declaring this, but I'd rather if you did declare
      '';
    };
    hasHidpi = mkEnableOption "hidpi";
  };
}
