{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.my.fd;
in {
  options.my.fd = {enable = mkEnableOption "fd" // {default = true;};};

  config = mkIf cfg.enable {
    programs.fd = {
      enable = true;
      ignores = [".git/" ".direnv/"];
      hidden = true;
    };
  };
}
