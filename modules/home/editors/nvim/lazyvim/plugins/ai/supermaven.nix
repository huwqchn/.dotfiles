{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  inherit (config.home) homeDirectory;
  cfg = config.my.neovim.lazyvim.supermaven;
in {
  options.my.neovim.lazyvim.supermaven = {
    enable = mkEnableOption "AI plugin - Supermaven";
  };

  config = mkIf cfg.enable {
    my.neovim.lazyvim.extraSpec = ''
      { import = "lazyvim.plugins.extras.ai.supermaven" },
    '';

    my.neovim.lazyvim.extraPlugins = with pkgs.vimPlugins; [
      supermaven-nvim
    ];

    age.secrets.supermaven = {
      rekeyFile = ./secrets/supermaven.age;
      path = "${homeDirectory}/.supermaven/config.json";
      symlink = false;
    };
  };
}
