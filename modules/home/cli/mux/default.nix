{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;
in {
  imports = lib.my.scanPaths ./.;

  options.my.mux = mkOption {
    type = enum ["tmux" "zellij"];
    default = "tmux";
    description = "The terminal multiplexer to use";
  };
}
