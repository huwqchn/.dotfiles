{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.my) scanPaths;
  inherit (lib.modules) mkDefault;
in {
  imports = [../../common/themes] ++ (scanPaths ./.);

  stylix = {
    iconTheme = mkDefault {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };
    targets = {
      # for hyprland wallpaper, maybe i also need swwww
      hyprpaper.enable = true;
    };
  };

  home = {
    # TODO: use gowall to change wallpaper to apply my colorscheme
    packages = with pkgs; [
      gowall
    ];

    # WARNING: This should not be used in `auto` theme, cause gowall is change a wallpaper to specific colorscheme
    # but `auto` theme is generate a colorshecme based on wallpaper
    # TODO: should make gowall working seemlessly
    # file.".config/gowall/config.yml".text = with config.lib.stylix.colors; ''
    #   themes:
    #     - name: "global"
    #       colors:
    #         - "#${base00}"
    #         - "#${base01}"
    #         - "#${base02}"
    #         - "#${base03}"
    #         - "#${base04}"
    #         - "#${base05}"
    #         - "#${base06}"
    #         - "#${base07}"
    #         - "#${base08}"
    #         - "#${base09}"
    #         - "#${base0A}"
    #         - "#${base0B}"
    #         - "#${base0C}"
    #         - "#${base0D}"
    #         - "#${base0E}"
    #         - "#${base0F}"
    # '';
  };
}
