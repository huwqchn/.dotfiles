{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.project;
in {
  options.my.neovim.lazyvim.project = {
    enable = mkEnableOption "project";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim = {
      extraPlugins = with pkgs.vimPlugins; [
        # WARNING: This plugin is override by other plugins with the same name
        project-nvim
      ];

      extraSpec = ''
        { import = "lazyvim.plugins.extras.util.project" },
      '';
    };
  };
}
