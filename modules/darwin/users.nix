{
  myvars,
  config,
  pkgs,
  ...
}: let
  inherit (myvars) userName;
  inherit (config.networking) hostName;
in {
  # Define a user account.
  users.users."${userName}" = {
    home = "/Users/${userName}";
    description = userName;
    shell = pkgs.fish; # https://github.com/LnL7/nix-darwin/issues/1237 still have a bug
  };
  nix.settings.trusted-users = [userName];

  networking.computerName = hostName;
  system.defaults.smb.NetBIOSName = hostName;
}
