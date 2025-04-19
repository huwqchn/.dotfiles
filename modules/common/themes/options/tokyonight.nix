{
  lib,
  config,
  ...
}: let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) enum;
in {
  options.my.themes.tokyonight = {
    enable =
      mkEnableOption "Tokyonight theme"
      // {
        default = config.my.themes.theme == "tokyonight";
      };

    style = mkOption {
      type = enum ["night" "storm" "day" "moon"];
      default = "moon";
      description = "The style of tokyonight";
    };
  };
}
