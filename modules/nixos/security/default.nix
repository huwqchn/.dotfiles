{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.my.security;
in {
  config = mkIf cfg.enable {
    # nix.extraOptions = ''
    #   !include ${config.age.secrets.nix-access-tokens.path}
    # '';

    # security with polkit
    security.polkit.enable = true;
    # security with gnome-kering
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.greetd.enableGnomeKeyring = true;

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
