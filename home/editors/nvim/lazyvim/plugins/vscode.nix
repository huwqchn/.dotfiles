{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.lazyvim.vscode;
in {
  options.my.lazyvim.vscode = {
    enable = mkEnableOption "LazyVim integration with Visual Studio Code";
  };

  config = mkIf cfg.enable {
    my.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.vscode"; }
    '';
  };
}
