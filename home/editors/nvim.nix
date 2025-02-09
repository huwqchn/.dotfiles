{
  config,
  pkgs,
  lib,
  # neovim-nightly,
  ...
}: let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_EDITOR = "nvim";
  };
  xdg = {
    configFile.nvim.source = mkOutOfStoreSymlink (lib.my.relativeToConfig "nvim");
    desktopEntries."nvim" = lib.mkIf pkgs.stdenv.isLinux {
      name = "NeoVim";
      comment = "Edit text files";
      icon = "nvim";
      exec = "xterm -e ${pkgs.neovim}/bin/nvim %F";
      categories = ["TerminalEmulator"];
      terminal = false;
      mimeType = ["text/plain"];
    };
  };

  programs.neovim = {
    enable = true;
    # package = neovim-nightly.packages.${pkgs.system}.default;

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
      ruff
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
      # image tools
      imagemagick
    ];
    extraLuaPackages = ps: [ps.magick];
  };

  home.persistence = {
    "/persist/${config.home.homeDirectory}".directories = [
      ".local/state/nvim"
      ".local/share/nvim"
      ".cache/nvim"
      ".local/share/TabNine"
      ".config/TabNine"
      ".config/github-copilot"
      ".codeium"
    ];
  };
}
