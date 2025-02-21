{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.black;
in {
  options.my.neovim.lazyvim.black = {
    enable = mkEnableOption "formatting tool - black";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      black
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.formatting.black" },
    '';
  };
}
