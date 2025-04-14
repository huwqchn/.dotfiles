{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.vue;
in {
  options.my.neovim.lazyvim.vue = {
    enable = mkEnableOption "language vue";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "vue"
        "css"
      ];
      lazyvim = {
        typescript.enable = true;

        extraSpec = ''
          { import = "lazyvim.plugins.extras.lang.vue" },
        '';
      };
    };

    programs.neovim.extraPackages = with pkgs; [
      vscode-extensions.vue.volar
      vtsls
    ];
  };
}
