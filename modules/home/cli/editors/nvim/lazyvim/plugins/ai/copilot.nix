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
  inherit (config.my) name;
  cfg = config.my.neovim.lazyvim.copilot;
  inherit (config.home) homeDirectory;
in {
  options.my.neovim.lazyvim.copilot = {
    enable = mkEnableOption "AI plugin - Copilot and Copilot-Chat";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [nodejs_24];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins;
      [CopilotChat-nvim copilot-lua]
      ++ lib.optionals (config.my.neovim.lazyvim.cmp == "nvim-cmp")
      [copilot-cmp]
      ++ lib.optionals (config.my.neovim.lazyvim.cmp
        == "blink"
        || config.my.neovim.lazyvim.cmp == "auto") [blink-cmp-copilot];

    xdg.configFile = mkMerge [
      (sourceLua config "ai/copilot.lua")
    ];

    sops.secrets.github-copilot = {
      sopsFile = "${self}/secrets/${name}/github-copilot";
      path = "${homeDirectory}/.config/github-copilot/apps.json";
      mode = "0400";
      format = "binary";
    };
  };
}
