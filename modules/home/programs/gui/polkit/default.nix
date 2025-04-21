{
  lib,
  config,
  ...
}: let
  inherit (lib.my) scanPaths;
  inherit (lib.options) mkOption;
  inherit (lib.types) enum;
  inherit (config.my) desktop;
  isHyprland = desktop.environment == "hyprland";
in {
  imports = scanPaths ./.;
  options.my.desktop.polkit = mkOption {
    type = enum ["pantheon" "hyprland"];
    default =
      if isHyprland
      then "hyprland"
      else "pantheon";
    description = ''
      The policy kit agent to use for authentication.
      This is the GUI that pops up when you need to enter a password for
      administrative tasks.
    '';
  };
}
