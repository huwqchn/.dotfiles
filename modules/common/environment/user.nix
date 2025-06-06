{
  config,
  pkgs,
  lib,
  self,
  ...
}: let
  inherit (config.my) name home;
  userGroup = lib.my.ldTernary pkgs "users" "admin";
  user_readable = {
    symlink = false;
    owner = name;
    mode = "0600";
    group = userGroup;
  };
  inherit (lib.strings) optionalString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.lists) forEach;
  persist = config.my.persistence.enable;
  shell = builtins.getAttr config.my.shell pkgs;
in {
  environment = {
    # add user's shell into /etc/shells
    shells = with pkgs; [
      bash
      fish
      zsh
    ];
  };

  programs = {
    fish.enable = true;
    zsh.enable = true;
  };

  # Define a user account.
  users.users."${name}" = {
    # https://github.com/LnL7/nix-darwin/issues/1237 still have a bug
    inherit home shell;
    description = name;

    # Public Keys that can be used to login to all hosts;
    openssh.authorizedKeys.keys =
      forEach
      (listFilesRecursive "${self}/secrets/${name}/keys")
      (key: builtins.readFile key);
  };

  age.secrets.my-ssh-key =
    {
      rekeyFile = "${self}/secrets/${name}/ssh.age";
      path = "${optionalString persist "/persist"}${home}/.ssh/id_${name}";
    }
    // user_readable;
}
