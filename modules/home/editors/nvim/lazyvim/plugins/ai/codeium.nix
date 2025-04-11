{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.codeium;
  inherit (config.home) homeDirectory;
in {
  options.my.neovim.lazyvim.codeium = {
    enable = mkEnableOption "AI plugin - Codeium";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.ai.codeium" },
    '';

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      codeium-nvim
    ];

    age.secrets.codeium = {
      rekeyFile = ./secrets/codeium.age;
      path = "${homeDirectory}/.cache/nvim/codeium/config.json";
      symlink = false;
    };
  };
}
