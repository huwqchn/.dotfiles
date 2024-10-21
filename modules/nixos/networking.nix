{
  config,
  pkgs,
  mylib,
  ...
}:
mylib.mkEnabledModule config "network" {
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

  # Use an NTP server located in the mainland of China to synchronize the system time
  networking.timeServers = [
    "ntp.aliyun.com" # Aliyun NTP Server
    "ntp.tencent.com" # Tencent NTP Server
  ];
}
