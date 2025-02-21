{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.codeium;
in {
  options.my.neovim.lazyvim.codeium = {
    enable = mkEnableOption "AI plugin - Codeium";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.ai.codeium" },
    '';

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      codeium-nvim
    ];
  };
}
