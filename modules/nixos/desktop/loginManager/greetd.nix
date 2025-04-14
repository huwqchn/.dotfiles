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
  cfg = config.my.desktop.loginManager;
  inherit (config.my) name;
  inherit (config.my.machine) persist;
in {
  options.my.desktop.loginManager.autologin =
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
      restart = !cfg.autologin;

      settings = {
        default_session = {
          user = "greeter";
          command = concatStringsSep " " [
            (getExe pkgs.greetd.tuigreet)
            "--time"
            "--remember"
            "--remember-user-session"
            "--asterisks"
            "--sessions '${sessionPath}'"
          ];
        };

        initial_session = mkIf cfg.autologin {
          user = name;
          command = cfg.default;
        };
      };
    };
  };
}
