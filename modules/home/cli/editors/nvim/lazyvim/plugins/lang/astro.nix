{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.astro;
in {
  options.my.neovim.lazyvim.astro = {
    enable = mkEnableOption "language astro";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "astro"
        "css"
      ];
      lazyvim = {
        typescript.enable = true;

        extraSpec = ''
          { import = "lazyvim.plugins.extras.lang.astro" },
        '';
      };
    };

    programs.neovim.extraPackages = with pkgs; [
      astro-language-server
    ];
  };
}
