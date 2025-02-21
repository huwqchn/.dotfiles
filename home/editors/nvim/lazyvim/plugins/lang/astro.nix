{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.astro;
in {
  options.my.neovim.lazyvim.astro = {
    enable = mkEnableOption "language astro";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.typescript.enable = true;

    programs.neovim.extraPackages = with pkgs; [
      astro-language-server
    ];

    my.neovim.treesitterParsers = [
      "astro"
      "css"
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.astro" },
    '';
  };
}
