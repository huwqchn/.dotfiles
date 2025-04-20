{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib.modules) mkIf;
  cfg = config.my.theme.tokyonight;
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  inherit (lib.generators) toINIWithGlobalSection;
  enable = cfg.enable && isLinux;
in {
  config = mkIf enable {
    i18n.inputMethod.fcitx5.addons = with pkgs; [fcitx5-tokyonight];
    xdg.configFile."fcitx5/conf/classicui.conf" = {
      enable = config.i18n.inputMethod.enabled == "fcitx5";
      text = let
        shade =
          if cfg.style == "day"
          then "Day"
          else "Storm";
      in
        toINIWithGlobalSection {} {
          globalSection = {
            Theme = "Tokyonight-${shade}";
            DarkTHeme = "Tokyonight-${shade}";
          };
        };
    };
  };
}
