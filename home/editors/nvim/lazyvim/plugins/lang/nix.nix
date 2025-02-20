{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.nix;
in {
  options.my.neovim.lazyvim.nix = {
    enable = mkEnableOption "language nix";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      nil
    ];

    my.neovim.treesitterParsers = [
      "nix"
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      haskellPackages.nixfmt
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.nix" },
    '';
  };
}
