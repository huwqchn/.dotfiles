{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.vscode;
in {
  options.my.neovim.lazyvim.vscode = {
    enable = mkEnableOption "LazyVim integration with Visual Studio Code";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.vscode"; },
    '';
  };
}
