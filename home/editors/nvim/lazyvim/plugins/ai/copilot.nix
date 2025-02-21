{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.copilot;
in {
  options.my.neovim.lazyvim.copilot = {
    enable = mkEnableOption "AI plugin - Copilot and Copilot-Chat";
  };

  config = mkIf cfg.enable {
    my.lazyvim.extraPlugins = with pkgs.vimPlugins;
      [
        CopilotChat-nvim
        copilot-lua
      ]
      ++ lib.optionals (my.neovim.lazyvim.cmp == "nvim-cmp") [copilot-cmp]
      ++ lib.optionals (my.neovim.lazyvim.cmp == "blink" || my.neovim.lazyvim.cmp == "auto") [blink-cmp-copilot];

    xdg.configFile."nvim/lua/plugins/copilot.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/ai/copilot.lua";
  };
}
