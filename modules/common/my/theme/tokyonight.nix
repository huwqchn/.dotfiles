{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) enum;
  inherit (config) my;
in {
  options.my.theme.tokyonight = {
    enable =
      mkEnableOption "Tokyonight theme"
      // {
        default = my.theme.default == "tokyonight";
      };

    #TODO: we need create a pr for tokyonight.nvim to generate tokyonight.nix
    style = mkOption {
      type = enum ["night" "storm" "day" "moon"];
      default = "moon";
      description = "The style of tokyonight";
    };
  };
}
