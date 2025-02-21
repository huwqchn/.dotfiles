{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.my.neovim.lazyvim;
in {
  config = mkIf (cfg.cmp == "auto" || cfg.cmp == "blink") {
    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      blink-cmp
      blink-compat
      friendly-snippets
    ];

    my.neovim.lazyvim.excludePlugins = with pkgs.vimPlugins; [
      nvim-cmp
    ];
  };
}
