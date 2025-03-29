{
  config,
  pkgs,
  ...
}: let
  inherit (config.my) name home shell;
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
}
