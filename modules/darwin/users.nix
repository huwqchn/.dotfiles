{
  config,
  pkgs,
  ...
}: let
  userName = config.my.name;
  myShell = config.my.shell;
  inherit (config.networking) hostName;
in {
  # Define a user account.
  users.users."${userName}" = {
    home = "/Users/${userName}";
    description = userName;
    shell =
      builtins.getAttr myShell
      pkgs; # https://github.com/LnL7/nix-darwin/issues/1237 still have a bug
  };
  nix.settings.trusted-users = [userName];

  networking.computerName = hostName;
  system.defaults.smb.NetBIOSName = hostName;
}
