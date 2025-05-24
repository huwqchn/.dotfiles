{config, ...}: let
  inherit (config.networking) hostName;
in {
  networking.computerName = hostName;
  system.defaults.smb.NetBIOSName = hostName;
  system.primaryUser = config.my.name;
}
