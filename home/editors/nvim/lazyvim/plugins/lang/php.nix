{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.php;
in {
  options.my.neovim.lazyvim.php = {
    enable = mkEnableOption "language php";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      phpactor
      intelephense
      php84Packages.php-codesniffer
      php84Packages.php-cs-fixer
    ];

    my.neovim.treesitterParsers = [
      "php"
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.php" },
    '';
  };
}
