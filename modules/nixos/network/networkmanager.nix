{pkgs, ...}: {
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openconnect
      networkmanager-l2tp
    ];
  };

  programs.nm-applet.enable = true;

  # Network discovery, mDNS, DNS-SD
  # With this enabled, you can access your machine at <hostname>.local
  # it's more convenient than using IP addresses
  # https://avahi.org/
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      domain = true;
      userServices = true;
    };
  };
}
