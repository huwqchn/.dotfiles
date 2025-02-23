{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
  inherit (config.my) terminal;
in {
  imports = lib.my.scanPaths ./.;

  options.my.terminal = mkOption {
    type = types.enum ["wzeterm" "alacritty" "ghostty" "kitty"];
    default = "ghostty";
    description = "The terminal to use";
  };

  config = {
    # home.sessionVariable = { TERMINAL = "${terminal}"; };
    my.ghostty.enable = terminal == "ghostty";
    my.kitty.enable = terminal == "kitty";
    my.alacritty.enable = terminal == "alacritty";
    my.wezterm.enable = terminal == "wezterm";
  };
}
