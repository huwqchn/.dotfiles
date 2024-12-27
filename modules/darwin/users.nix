{ 
  myvars,
  config,
  ...
}: let
  userName = myvars.userName;
  hostName = config.networking.hostName;
in {
  # Define a user account.
  users.users."${userName}" = {
    home = "/Users/${userName}";
    description = userName;
  };

  nix.settings.trusted-users = [userName];

  networking.computerName = hostName;
  system.defaults.smb.NetBIOSName = hostName;
}
