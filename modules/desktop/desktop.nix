{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    wl-gammactl
    wl-clipboard
    wayshot
    pavucontrol
    brightnessctl
    swww
  ];

  services = {
    gvfs.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    accounts-daemon.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
      tracker-miners.enable = true;
      tracker.enable = true;
    };
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d '/var/cache/greeter' - greeter greeter - -"
  ];

  # fix https://github.com/ryan4yin/nix-config/issues/10
  security = {
    polkit.enable = true;
    pam.services = {
      swaylock = {};
      ags = {};
    };
  };
}
