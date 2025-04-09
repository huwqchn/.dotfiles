{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.tailwind;
in {
  options.my.neovim.lazyvim.tailwind = {
    enable = mkEnableOption "language tailwind";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      tailwindcss
    ];

    /*
       my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      tailwindcss-colorizer-cmp-nvim
    ];
    */

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.tailwind" },
    '';
  };
}
