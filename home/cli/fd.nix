{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf types mkOption;
  cfg = config.my.fd;
in {
  options.my.fd = {
    enable = mkOption {
      default = true;
      type = types.bool;
      description = "Enable fd";
    };
  };

  config = mkIf cfg.enable {
    programs.fd = {
      enable = true;
      ignores = [".git/" ".direnv/"];
      hidden = true;
    };
  };
}
