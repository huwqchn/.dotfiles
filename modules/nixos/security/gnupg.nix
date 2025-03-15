{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.my.security.gnupg;
in {
  options.my.security.gnupg = {
    enable =
      mkEnableOption "Enable gnupg"
      // {
        default = config.my.security.enable;
      };
  };

  config = mkIf cfg.enable {
    # gpg agent with pinentry
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = false;
      enableExtraSocket = true;
      pinentryPackage =
        if config.qt.enable
        then pkgs.pinentry-qt
        else pkgs.pinentry-tty;
      settings.default-cache-ttl = 4 * 60 * 60; # 4 hours
    };
  };
}
