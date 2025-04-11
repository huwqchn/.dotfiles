{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.markdown;
in {
  options.my.neovim.lazyvim.markdown = {
    enable = mkEnableOption "language markdown";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      markdownlint-cli2
      marksman
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      markdown-preview-nvim
      render-markdown-nvim
    ];

    xdg.configFile."nvim/lua/plugins/markdown.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/lang/markdown.lua";
  };
}
