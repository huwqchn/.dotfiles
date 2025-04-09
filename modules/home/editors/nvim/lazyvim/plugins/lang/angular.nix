{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.angular;
in {
  options.my.neovim.lazyvim.angular = {
    enable = mkEnableOption "language angular";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.typescript.enable = true;

    programs.neovim.extraPackages = with pkgs; [
      angular-language-server
    ];

    my.neovim.treesitterParsers = [
      "angular"
      "scss"
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.angular" },
    '';
  };
}
