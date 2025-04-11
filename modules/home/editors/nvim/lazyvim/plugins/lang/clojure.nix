{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.clojure;
in {
  options.my.neovim.lazyvim.clojure = {
    enable = mkEnableOption "language clojure";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      astro-language-server
    ];

    my.neovim.treesitterParsers = [
      "clojure"
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins;
      [
        nvim-treesitter-sexp
        baleia-nvim
        conjure
      ]
      ++ lib.optionals (my.neovim.lazyvim.cmp == "nvim-cmp") [cmp-conjure];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.clojure" },
    '';
  };
}
