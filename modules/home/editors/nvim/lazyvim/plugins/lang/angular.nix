{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.angular;
in {
  options.my.neovim.lazyvim.angular = {
    enable = mkEnableOption "language angular";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "angular"
        "scss"
      ];

      lazyvim = {
        typescript.enable = true;

        extraSpec = ''
          { import = "lazyvim.plugins.extras.lang.angular" },
        '';
      };
    };

    programs.neovim.extraPackages = with pkgs; [
      angular-language-server
    ];
  };
}
