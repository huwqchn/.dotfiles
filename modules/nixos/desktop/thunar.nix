{ lib, config, ... }: let
  inherit (lib) mkIf;
  cfg = config.my.desktop;
in {
  config = mkIf cfg.enable {
    # Thumbnail support for images
    services.tumbler.enable = true;
    programs = {
      # thunar file manager(part of xfce) related options
      thunar = {
        enable = true;
        plugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar-volman
        ];
      };
    };
  };
}
