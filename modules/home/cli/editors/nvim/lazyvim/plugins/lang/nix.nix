{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.my) sourceLua;
  cfg = config.my.neovim.lazyvim.nix;
in {
  options.my.neovim.lazyvim.nix = {enable = mkEnableOption "language nix";};

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [nil alejandra];

    my.neovim.treesitterParsers = ["nix"];

    # my.neovim.lazyvim.extraSpec = ''
    #   { import = "lazyvim.plugins.extras.lang.nix" },
    # '';
    xdg.configFile = mkMerge [
      (sourceLua config "lang/nix.lua")
    ];
  };
}
