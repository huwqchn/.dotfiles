{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.eslint;
in {
  options.my.neovim.lazyvim.eslint = {
    enable = mkEnableOption "linting tool - eslint";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.linting.eslint" },
    '';
  };
}
