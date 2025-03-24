{
  config,
  pkgs,
  self,
  ...
}: let
  inherit (config.my) name home shell;
  user_readable = {
    symlink = false;
    owner = config.my.name;
    mode = "0500";
  };
in {
  environment = {
    # add user's shell into /etc/shells
    shells = with pkgs; [
      bashInteractive
      shell
    ];
  };
  # Define a user account.
  users = {
    # set user's default shell system-wide
    defaultUserShell = pkgs.bashInteractive;
    users."${name}" = {
      inherit home;
      description = name;
      shell =
        builtins.getAttr shell
        pkgs; # https://github.com/LnL7/nix-darwin/issues/1237 still have a bug
    };
  };

  age.secrets = {
    my-ssh-key =
      {
        rekeyFile = "${self}/secrets/${name}/ssh-key.age";
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
