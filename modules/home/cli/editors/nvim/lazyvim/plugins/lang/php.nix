{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.php;
in {
  options.my.neovim.lazyvim.php = {
    enable = mkEnableOption "language php";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "php"
      ];

      lazyvim.extraSpec = ''
        { import = "lazyvim.plugins.extras.lang.php" },
      '';
    };

    programs.neovim.extraPackages = with pkgs; [
      phpactor
      intelephense
      php84Packages.php-codesniffer
      # php84Packages.php-cs-fixer
    ];
  };
}
