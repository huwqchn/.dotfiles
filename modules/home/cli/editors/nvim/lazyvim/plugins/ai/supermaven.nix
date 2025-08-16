{
  self,
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
    my.neovim.lazyvim = {
      extraPlugins = with pkgs.vimPlugins; [
        supermaven-nvim
      ];

      extraSpec = ''
        { import = "lazyvim.plugins.extras.ai.supermaven" },
      '';
    };

    sops.secrets.supermaven = {
      sopsFile = "${self}/secrets/supermaven";
      path = "${homeDirectory}/.supermaven/config.json";
      mode = "0400";
      format = "binary";
    };

    home.persistence."/persist${config.home.homeDirectory}".directories = [
      ".local/share/supermaven"
    ];
  };
}
