{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.dap;
in {
  options.my.neovim.lazyvim.dap = {
    enable = mkEnableOption "Debugging support";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-nio
      one-small-step-for-vimkind
    ];

    # disable mason-nvim-dap.nvim
    my.neovim.lazyvim.extraSpec = ''
      { "jay-babu/mason-nvim-dap.nvim", enabled = false },
    '';

    xdg.configFile."nvim/lua/plugins/dap.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/editor/dap.lua";
  };
}
