{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.security.fprint;
in {
  options.my.security.fprint = {
    enable = mkIf "Enable fingerprint login";
  };

  config = mkIf cfg.enable {
    # fingerprint login
    # doesn't work because thanks drivers
    services.fprintd = {
      enable = true;
      tod = {
        enable = true;
        driver = pkgs.libfprint-2-tod1-goodix;
      };
    };
  };
}
