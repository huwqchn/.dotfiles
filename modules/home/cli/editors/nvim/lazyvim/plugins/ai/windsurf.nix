{
  self,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.my) sourceLua;
  cfg = config.my.neovim.lazyvim.windsurf;
  inherit (config.home) homeDirectory;
in {
  options.my.neovim.lazyvim.windsurf = {
    enable = mkEnableOption "AI plugin - windsurf";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim = {
      extraPlugins = with pkgs.vimPlugins; [
        windsurf-nvim
      ];

      # extraSpec = ''
      #   { import = "lazyvim.plugins.extras.ai.codeium" },
      # '';
    };

    xdg.configFile = mkMerge [
      (sourceLua config "ai/windsurf.lua")
    ];

    sops.secrets.codeium = {
      sopsFile = "${self}/secrets/codeium";
      path = "${homeDirectory}/.cache/nvim/codeium/config.json";
      mode = "0400";
      format = "binary";
    };
  };
}
