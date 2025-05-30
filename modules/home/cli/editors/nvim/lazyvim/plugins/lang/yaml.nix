{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.yaml;
in {
  options.my.neovim.lazyvim.yaml = {
    enable = mkEnableOption "language yaml";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "yaml"
      ];
      lazyvim = {
        extraPlugins = with pkgs.vimPlugins; [
          SchemaStore-nvim
        ];
        extraSpec = ''
          { import = "lazyvim.plugins.extras.lang.yaml" },
        '';
      };
    };

    programs.neovim.extraPackages = with pkgs; [
      yaml-language-server
    ];
  };
}
