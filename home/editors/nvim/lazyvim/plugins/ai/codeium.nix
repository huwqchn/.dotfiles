{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.lazyvim.codeium;
in {
  options.my.lazyvim.codeium = {
    enable = mkEnableOption "AI plugin - Codeium";
  };

  config = mkIf cfg.enable {
    my.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.ai.codeium" },
    '';

    my.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      codeium-nvim
    ];
  };
}
