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
  inherit (lib) optionals;
  cfg = config.my.neovim.lazyvim.copilot;
  inherit (config.home) homeDirectory;
in {
  options.my.neovim.lazyvim.copilot = {
    lua.enable = mkEnableOption "AI plugin - Copilot and Copilot-Chat";
    native.enable = mkEnableOption "Using native Copilot or using copilot.lua";
    chat.enable = mkEnableOption "AI plugin - Copilot-Chat";
  };

  assertions = [
    {
      assertion = !(cfg.lua.enable && cfg.native.enable);
      message = "Copilot: choose either copilot.lua (copilot.enable) OR native LSP (copilot.native.enable), not both.";
    }
  ];

  config = mkMerge [
    (mkIf (cfg.lua.enable || cfg.native.enable || cfg.chat.enable) {
      programs.neovim.extraPackages = with pkgs; [nodejs_24];

      sops.secrets.github-copilot = {
        sopsFile = "${self}/secrets/${name}/github-copilot";
        path = "${homeDirectory}/.config/github-copilot/apps.json";
        mode = "0400";
        format = "binary";
      };
    })
    (mkIf cfg.lua.enable {
      my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins;
        [copilot-lua]
        ++ optionals (config.my.neovim.lazyvim.cmp == "nvim-cmp")
        [copilot-cmp]
        ++ optionals (config.my.neovim.lazyvim.cmp
          == "blink"
          || config.my.neovim.lazyvim.cmp == "auto") [blink-cmp-copilot];

      xdg.configFile = mkMerge [
        (sourceLua config "ai/copilot.lua")
      ];
    })
    (mkIf cfg.chat.enable {
      my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [CopilotChat-nvim];
      xdg.configFile = mkMerge [
        (sourceLua config "ai/copilot-chat.lua")
      ];
    })
    (mkIf cfg.native.enable {
      extraSpec = ''
        { import = "lazyvim.plugins.extras.ai.copilot-native" },
      '';
    })
  ];
}
