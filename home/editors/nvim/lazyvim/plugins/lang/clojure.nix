{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.clojure;
in {
  options.my.neovim.lazyvim.clojure = {
    enable = mkEnableOption "language astro";
  };

  config = mkIf cfg.enable {
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
