{
  config,
  pkgs,
  lib,
  self,
  ...
}: let
  inherit (config.my) name home shell;
  userGroup = lib.my.ldTernary pkgs "users" "admin";
  user_readable = {
    symlink = false;
    owner = name;
    mode = "0600";
    group = userGroup;
  };
in {
  environment = {
    # add user's shell into /etc/shells
    shells = with pkgs; [
      bashInteractive
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
    inherit home;
    shell =
      if shell == "fish"
      then pkgs.fish
      else if shell == "zsh"
      then pkgs.zsh
      else pkgs.bashInteractive;
    description = name;
  };

  age.secrets.my-ssh-key =
    {
      rekeyFile = "${self}/secrets/${name}/ssh.age";
      path = "${home}/.ssh/id_ed25519";
    }
    // user_readable;
}
