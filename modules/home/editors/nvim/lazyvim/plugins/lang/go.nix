{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.go;
in {
  options.my.neovim.lazyvim.go = {
    enable = mkEnableOption "language go";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      delve
      gopls
      gotools
      gofumpt
      gomodifytags
      impl
    ];

    my.neovim.treesitterParsers = [
      "go"
      "gomod"
      "gowork"
      "gosum"
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      nvim-dap-go
      neotest-golang
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.go" },
    '';
  };
}
