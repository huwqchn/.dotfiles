{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.typescript;
in {
  options.my.neovim.lazyvim.typescript = {
    enable = mkEnableOption "language typescript";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      typescript-language-server
      vtsls
    ];

    my.neovim.treesitterParsers = [
      "javascript"
      "typescript"
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.typescript" },
    '';
  };
}
