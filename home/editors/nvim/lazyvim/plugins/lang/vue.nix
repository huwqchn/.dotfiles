{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.vue;
in {
  options.my.neovim.lazyvim.vue = {
    enable = mkEnableOption "language vue";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.typescript = true;

    programs.neovim.extraPackages = with pkgs; [
      vscode-extensions.vue.volar
      vtsls
    ];

    my.neovim.treesitterParsers = [
      "vue"
      "css"
    ];

    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.lang.vue" },
    '';
  };
}
