{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.lean;
in {
  options.my.neovim.lazyvim.lean = {enable = mkEnableOption "language lean";};

  config = mkIf cfg.enable {
    my.neovim.lazyvim = {
      extraPlugins = with pkgs.vimPlugins; [
        lean-nvim
      ];
      extraSpec = ''
        { import = "lazyvim.plugins.extras.lang.lean" },
      '';
    };
  };
}
