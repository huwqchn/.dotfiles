{ lib, config, ... }: let
  inherit (lib) mkIf;
  cfg = config.my.desktop;
in {
  config = mkIf cfg.enable {
    services = {
      # Thumbnail support for images
      tumbler.enable = true;
      # Mount, trash, and other functionalities
      gvfs.enable = true;
      # storage daemon required for udiskie auto-mount
      udisks2.enable = true;
    };

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
