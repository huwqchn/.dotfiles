{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.omnisharp;
in {
  options.my.neovim.lazyvim.omnisharp = {
    enable = mkEnableOption "language omnisharp";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      csharpier
      netcoredbg
    ];

    my.neovim.treesitterParsers = [
      "c_sharp"
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      neotest-dotnet
      omnisharp-extended-lsp-nvim
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.omnisharp" },
    '';
  };
}
