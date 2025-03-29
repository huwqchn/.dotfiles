{
  config,
  pkgs,
  self,
  ...
}: let
  inherit (config.my) name home;
  user_readable = {
    symlink = false;
    owner = config.my.name;
    mode = "0500";
  };
  shell = builtins.getAttr config.my.shell pkgs;
in {
  environment = {
    # add user's shell into /etc/shells
    shells = with pkgs; [
      bashInteractive
      shell
    ];
  };
  # Define a user account.
  users.users."${name}" = {
    # https://github.com/LnL7/nix-darwin/issues/1237 still have a bug
    inherit home shell;
    description = name;
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
        rekeyFile = ./secrets/git-credentials.age;
        path = "${home}/.git-credentials";
      }
      // user_readable;
  };
}
