{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkOption mkEnableOption;
  inherit (lib.types) enum;
  inherit (config) my;
in {
  options.my.themes.tokyonight = {
    enable =
      mkEnableOption "Tokyonight theme"
      // {
        default = my.themes.theme == "tokyonight";
      };

    style = mkOption {
      type = enum ["night" "storm" "day" "moon"];
      default = "moon";
      description = "The style of tokyonight";
    };
  };
}
