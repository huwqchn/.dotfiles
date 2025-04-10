{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.supermaven;
  inherit (config.home) homeDirectory;
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
