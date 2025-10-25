{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;
in {
  imports = lib.my.scanPaths ./.;

  options.my.mux = {
    default = mkOption {
      type = enum ["tmux" "zellij"];
      default = "tmux";
      description = "The terminal multiplexer to use";
    };
    autoStart = mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to start the terminal multiplexer automatically";
    };
  };
}
