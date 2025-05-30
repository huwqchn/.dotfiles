{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.ansible;
in {
  options.my.neovim.lazyvim.ansible = {
    enable = mkEnableOption "language ansible";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "angular"
        "scss"
      ];

      lazyvim.extraSpec = ''
        { import = "lazyvim.plugins.extras.lang.ansible" },
      '';
    };

    programs.neovim.extraPackages = with pkgs; [
      ansible-lint
      ansible-language-server
    ];
  };
}
