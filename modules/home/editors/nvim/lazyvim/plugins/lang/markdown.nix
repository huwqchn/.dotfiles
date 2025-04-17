{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.my) sourceLua;
  cfg = config.my.neovim.lazyvim.markdown;
in {
  options.my.neovim.lazyvim.markdown = {
    enable = mkEnableOption "language markdown";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      markdown-preview-nvim
      render-markdown-nvim
    ];

    programs.neovim.extraPackages = with pkgs; [
      markdownlint-cli2
      marksman
    ];

    xdg.configFile = mkMerge [
      (sourceLua "lang/markdown.lua")
    ];
  };
}
