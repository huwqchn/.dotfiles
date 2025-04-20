{
  lib,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.themes.tokyonight;
  inherit (config.my.themes) transparent;
in {
  config = mkIf cfg.enable {
    programs.nixcord.config = {
      inherit transparent;
      frameless = true;
      enabledThemes = [
        "tokyo-night.theme.css"
      ];
      themeLinks = [
        "https://raw.githubusercontent.com/Dyzean/Tokyo-Night/main/themes/tokyo-night.theme.css"
      ];
    };
  };
}
