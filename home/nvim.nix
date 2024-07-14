{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    
    withRuby = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      git
      gcc
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
