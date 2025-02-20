{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.docker;
in {
  options.my.neovim.lazyvim.docker = {
    enable = mkEnableOption "language docker";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      hadolint
    ];

    my.neovim.treesitterParsers = [
      "dockerfile"
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.docker" },
    '';
  };
}
