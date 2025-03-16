{
  config,
  pkgs,
  ...
}: {
  # gpg agent with pinentry
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    enableExtraSocket = true;
    pinentryPackage =
      if config.qt.enable
      then pkgs.pinentry-qt
      else pkgs.pinentry-tty;
    settings.default-cache-ttl = 4 * 60 * 60; # 4 hours
  };
}
