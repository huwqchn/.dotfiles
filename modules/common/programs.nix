{config, ...}: let
  inherit (config.my) shell;
in {
  programs = {
    fish.enable = shell == "fish";
    zsh.enable = shell == "zsh";
    # nushell.enable = shell == "nushell";
  };
}
