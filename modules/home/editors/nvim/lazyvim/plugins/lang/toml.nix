{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.toml;
in {
  options.my.neovim.lazyvim.toml = {
    enable = mkEnableOption "language toml";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      taplo
    ];

    my.neovim.treesitterParsers = [
      "toml"
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.toml" },
    '';
  };
}
