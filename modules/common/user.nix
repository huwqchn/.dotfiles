{
  config,
  pkgs,
  self,
  ...
}: let
  userName = config.my.name;
  myShell = config.my.shell;
  inherit (config.my) home;
  user_readable = {
    symlink = false;
    owner = config.my.name;
    mode = "0500";
  };
in {
  # Define a user account.
  users.users."${userName}" = {
    inherit home;
    description = userName;
    shell =
      builtins.getAttr myShell
      pkgs; # https://github.com/LnL7/nix-darwin/issues/1237 still have a bug
  };

  age.secrets = {
    my-ssh-key =
      {
        rekeyFile = "${self}/secrets/${userName}/ssh-key.age";
        path = "${home}/.ssh/johnson-hu-ssh-key";
      }
      // user_readable;
    git-credentials =
      {
        rekeyFile = ./git-credentials.age;
        path = "${home}/.git-credentials";
      }
      // user_readable;
  };
}
