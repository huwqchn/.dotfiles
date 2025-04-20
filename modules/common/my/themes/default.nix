{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.my) scanPaths;
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) enum str nullOr package path coercedTo attrs;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  inherit (config) my;
in {
  imports = scanPaths ./.;

  options.my.themes = {
    # TODO: wallpaper engine support?
    wallpaper = mkOption {
      type = nullOr (coercedTo package toString path);
      # we don't set wallpaper on macos, because it doesn't work
      default =
        if isDarwin
        then null
        else if my.desktop.enable
        then ./themes/walls/nix.png
        # pkgs.fetchurl {
        #   url = "https://github.com/huwqchn/wallpapers/blob/main/unorganized/nix.png";
        #   sha256 = "11qgd9k79fhpsk7x0q3cwin8i1ycf9kcd6c3si7sdck78rdhdwl8";
        # }
        else null;
      description = "The wallpaper of the system";
    };
    theme = mkOption {
      type = nullOr (enum ["tokyonight" "catppuccin"]);
      default = "tokyonight";
      description = "The theme to use";
    };
    colorscheme = {
      slug = mkOption {
        type = nullOr str;
        default = null;
        description = "The slug of the colorscheme";
      };
      name = mkOption {
        type = nullOr str;
        default = null;
        description = "The name of the colorscheme";
      };
      author = mkOption {
        type = nullOr str;
        default = null;
        description = "The author of the colorscheme";
      };
      description = mkOption {
        type = nullOr str;
        default = null;
        description = "The description of the colorscheme";
      };
      palette = mkOption {
        type = nullOr attrs;
        default = null;
        description = "The palette of the colorscheme";
      };
    };
    transparent =
      mkEnableOption "Enable tmux transparent"
      // {
        default = true;
      };
    pad = {
      left = mkOption {
        type = str;
        default = "";
        description = "The left padding of status bar";
      };
      right = mkOption {
        type = str;
        default = "";
        description = "The right padding of status bar";
      };
    };
  };
}
