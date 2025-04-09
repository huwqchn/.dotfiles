{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.yaml;
in {
  options.my.neovim.lazyvim.yaml = {
    enable = mkEnableOption "language yaml";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      yaml-language-server
    ];

    my.neovim.treesitterParsers = [
      "yaml"
    ];

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      SchemaStore-nvim
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.yaml" },
    '';
  };
}
