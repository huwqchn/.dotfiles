{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.prettier;
in {
  options.my.neovim.lazyvim.biome = {
    enable = mkEnableOption "formatting tool - prettier";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      prettier
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.formatting.prettier" },
    '';
  };
}
