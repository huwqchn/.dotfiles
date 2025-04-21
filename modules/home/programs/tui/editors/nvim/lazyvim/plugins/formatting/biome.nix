{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.biome;
in {
  options.my.neovim.lazyvim.biome = {
    enable = mkEnableOption "formatting tool - biome";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      biome
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.formatting.biome" },
    '';
  };
}
