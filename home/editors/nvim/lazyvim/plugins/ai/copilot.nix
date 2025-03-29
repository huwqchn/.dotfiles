{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.copilot;
  user_readable = {
    symlink = false;
    mode = "0500";
  };
in {
  options.my.neovim.lazyvim.copilot = {
    enable = mkEnableOption "AI plugin - Copilot and Copilot-Chat";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [nodejs_23];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins;
      [CopilotChat-nvim copilot-lua]
      ++ lib.optionals (config.my.neovim.lazyvim.cmp == "nvim-cmp")
      [copilot-cmp]
      ++ lib.optionals (config.my.neovim.lazyvim.cmp
        == "blink"
        || config.my.neovim.lazyvim.cmp == "auto") [blink-cmp-copilot];

    xdg.configFile."nvim/lua/plugins/copilot.lua".source =
      lib.my.relativeToConfig "nvim/lua/plugins/extras/ai/copilot.lua";

    age.secrets = {
      github-copilot =
        {
          rekeyFile = ./secrets/github-copilot.age;
          path = "${config.my.home}/.config/github-copilot/apps.json";
        }
        // user_readable;
    };
  };
}
