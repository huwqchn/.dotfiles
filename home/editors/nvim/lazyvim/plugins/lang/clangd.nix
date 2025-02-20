{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.my.neovim.lazyvim.clangd;
in {
  options.my.neovim.lazyvim.clangd = {
    enable = mkEnableOption "language clangd";
  };

  config = mkIf cfg.enable {
    programs.neovim.extraPackages = with pkgs; [
      vscode-extensions.vadimcn.vscode-lldb
    ];

    my.neovim.treesitterParsers = [
      "cpp"
    ];

    xdg.configFile."nvim/lua/plugins/clangd.lua".source = lib.my.relativeToConfig "nvim/lua/plugins/extras/lang/clangd.lua";
  };
}
