{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.codeium;
  user_readable = {
    symlink = false;
    mode = "0500";
  };
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

    age.secrets = {
      codeium =
        {
          rekeyFile = ./secrets/codeium.age;
          path = "${config.my.home}/.cache/nvim/codeium/config.json";
        }
        // user_readable;
    };
  };
}
