{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.nix;
in {
  options.my.neovim.lazyvim.nix = {enable = mkEnableOption "language nix";};

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [nil alejandra];

    my.neovim.treesitterParsers = ["nix"];

    # my.neovim.lazyvim.extraSpec = ''
    #   { import = "lazyvim.plugins.extras.lang.nix" },
    # '';
    xdg.configFile."nvim/lua/plugins/nix.lua".source =
      lib.my.relativeToConfig "nvim/lua/plugins/extras/lang/nix.lua";
  };
}
