{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkOption mkEnableOption types;
  inherit (pkgs.stdenv) isLinux;
in {
  options.my = {
    name = mkOption {
      type = types.str;
      default = "johnson";
      description = "The user name";
    };
    fullName = mkOption {
      type = types.str;
      default = "Johnson Hu";
      description = "The user full name";
    };
    email = mkOption {
      type = types.str;
      default = "johnson.wq.hu@gmail.com";
      description = "The user email";
    };
    home = mkOption {
      type = types.str;
      default = let
        user = config.my.name;
      in
        if isLinux
        then "/home/${user}"
        else "/Users/${user}";
      description = "The user home directory";
    };
    desktop = {enable = mkEnableOption "Desktop";};
    security = {enable = mkEnableOption "Security";};
    theme = mkOption {
      type = types.enum ["tokyonight" "catppuccin" "auto"];
      default = "tokyonight";
      description = "The theme to use";
    };
    shell = mkOption {
      type = types.enum ["bash" "fish" "zsh" "nushell"];
      default = "fish";
      description = "The shell to use";
    };
    wallpaper = mkOption {
      type = types.str;
      default = "wallpapers/1.jpg";
      description = "The wallpaper of the system";
    };
    initialHashedPassword = mkOption {
      type = types.singleLineStr;
      # generated by `mkpasswd -m scrypt`
      # we have to use initialHashedPassword here when using tmpfs for /
      default = "$y$j9T$UtvejDe22fK.4ok7ZyI1Y/$.vc/kQ3hRFbb2ntOCQQna3CcWWP6dxwtEAE1O9bWcO8";
      description = "The hashed password of the user";
    };
    # hardware
    nvidia = {enable = mkEnableOption "nvidia";};
    isHidpi = mkEnableOption "hidpi";
    persist = {enable = mkEnableOption "persist";}; # must use tmpfs for /
    # TODO: Generate a public key that can login to all my devices and servers.
    # store the privaet key in Yukikey
  };
}
