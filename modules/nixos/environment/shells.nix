{ config, pkgs, ... }: let
  inherit (config.my) shell;
  inherit (config.my) name;
in {
  environment = {
    # add user's shell into /etc/shells
    shells = with pkgs; [
      bashInteractive
      ${shell}
    ];
  };

  users = {
    # set user's default shell system-wide
    defaultUserShell = pkgs.bashInteractive;
    users.${name}.shell = pkgs.${shell};
  };
}
