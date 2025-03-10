{
  config,
  lib,
  ...
}: let
  cfg = config.my.fd;
  inherit (lib) mkEnableOption mkIf;
in {
  options.my.fd = {
    enable = mkEnableOption "fd";
  };
  config = mkIf cfg.enable {
    programs.fd = {
      enable = true;
      ignores = [".git/" ".direnv/"];
      hidden = true;
    };
  };
}
