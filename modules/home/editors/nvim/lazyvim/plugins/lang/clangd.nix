{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.my.neovim.lazyvim.clangd;
in {
  options.my.neovim.lazyvim.clangd = {
    enable = mkEnableOption "language clangd";
  };

  config = mkIf cfg.enable {
    my.neovim = {
      treesitterParsers = [
        "cpp"
      ];

      lazyvim.extraPlugins = with pkgs.vimPlugins; [
        clangd_extensions-nvim
      ];
    };

    programs.neovim.extraPackages = with pkgs; [
      vscode-extensions.vadimcn.vscode-lldb
      clang-tools
    ];

    xdg.configFile."nvim/lua/plugins/clangd.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/lang/clangd.lua";
  };
}
