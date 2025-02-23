{
  lib,
  config,
  ...
}: let
  inherit (config.my) shell;
in {
  imports = lib.my.scanPaths ./.;

  config = {
    my.fish.enable = shell == "fish";
    my.nushell.enable = shell == "nushell";
    my.zsh.enable = shell == "zsh";
  };
}
