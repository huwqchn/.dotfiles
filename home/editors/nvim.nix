{ pkgs, pkgs-unstable, lib, mylib, neovim-nightly, ... }:
{
  xdg = {
    configFile.nvim.source = mylib.relativeToConfig "nvim";
    desktopEntries."nvim" = lib.mkIf pkgs.stdenv.isLinux {
      name = "NeoVim";
      comment = "Edit text files";
      icon = "nvim";
      exec = "xterm -e ${pkgs-unstable.neovim}/bin/nvim %F";
      categories = [ "TerminalEmulator" ];
      terminal = false;
      mimeType = [ "text/plain" ];
    };
  };

  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withRuby = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      git
      gcc
      lua
      python313
      libclang
      luarocks
      # lsp
      ruff
      nodePackages.volar
      zig
      gopls
      rustc
      gnumake
      unzip
      wget
      curl
      tree-sitter
      ripgrep
      fd
      fzf
      cargo
      nil
      lua-language-server
      stylua
      alejandra
    ];
  };
}
