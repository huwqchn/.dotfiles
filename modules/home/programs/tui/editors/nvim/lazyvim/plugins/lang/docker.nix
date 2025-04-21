{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.docker;
in {
  options.my.neovim.lazyvim.docker = {
    enable = mkEnableOption "language docker";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "dockerfile"
      ];
      lazyvim.extraSpec = ''
        { import = "lazyvim.plugins.extras.lang.docker" },
      '';
    };

    programs.neovim.extraPackages = with pkgs; [
      hadolint
    ];
  };
}
