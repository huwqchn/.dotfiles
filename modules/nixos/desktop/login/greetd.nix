{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.strings) concatStringsSep;
  inherit (lib.options) mkEnableOption;

  sessionData = config.services.displayManager.sessionData.desktops;
  sessionPath = concatStringsSep ":" [
    "${sessionData}/share/xsessions"
    "${sessionData}/share/wayland-sessions"
  ];
  cfg = config.my.desktop.login;
  inherit (config.my) name;
  inherit (config.my.desktop) autologin environment;
  persist = config.my.persistence.enable;
in {
  options.my.desktop.autologin =
    mkEnableOption ''
      Whether to enable passwordless login. This is generally useful on systems with
      FDE (Full Disk Encryption) enabled. It is a security risk for systems without FDE.
    ''
    // {
      default = persist;
    };

  config = mkIf (cfg == "greetd") {
    services.greetd = {
      enable = true;
      vt = 2;
      restart = !autologin;

      settings = {
        default_session = {
          user = "greeter";
          command = concatStringsSep " " [
            (getExe pkgs.greetd.tuigreet)
            "--greeting 'Welcome to NixOS!'"
            "--time"
            "--remember"
            "--remember-user-session"
            "--asterisks"
            "--sessions '${sessionPath}'"
          ];
        };

        initial_session = mkIf autologin {
          user = name;
          command = environment;
        };
      };
    };
  };
}
