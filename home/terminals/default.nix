{lib, ...}: let
  inherit (lib) mkOption types;
  # inherit (config.my) terminal;
in {
  options.my.terminal = mkOption {
    type = types.enum ["wzeterm" "alacritty" "ghostty" "kitty"];
    default = "ghostty";
    description = "The terminal to use";
  };

  imports = lib.my.scanPaths ./.;

  # home.sessionVariable = { TERMINAL = "${terminal}"; };
}
