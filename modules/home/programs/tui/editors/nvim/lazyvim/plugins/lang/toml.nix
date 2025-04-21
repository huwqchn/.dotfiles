{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.toml;
in {
  options.my.neovim.lazyvim.toml = {
    enable = mkEnableOption "language toml";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "toml"
      ];

      lazyvim.extraSpec = ''
        { import = "lazyvim.plugins.extras.lang.toml" },
      '';
    };

    programs.neovim.extraPackages = with pkgs; [
      taplo
    ];
  };
}
