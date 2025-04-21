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
    my.neovim = {
      treesitterParsers = [
        "clojure"
      ];
      lazyvim = {
        extraPlugins = with pkgs.vimPlugins;
          [
            nvim-treesitter-sexp
            baleia-nvim
            conjure
          ]
          ++ lib.optionals (my.neovim.lazyvim.cmp == "nvim-cmp") [cmp-conjure];

        extraSpec = ''
          { import = "lazyvim.plugins.extras.lang.clojure" },
        '';
      };
    };

    programs.neovim.extraPackages = with pkgs; [
      astro-language-server
    ];
  };
}
