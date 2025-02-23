{lib, ...}: let
  inherit (lib) mkDefault;
in {
  imports = lib.my.scanPaths ./.;
  config = {
    my = {
      atuin.enable = mkDefault true;
      bat.enable = mkDefault true;
      direnv.enable = mkDefault true;
      eza.enable = mkDefault true;
      fastfetch.enable = mkDefault true;
      fzf.enable = mkDefault true;
      git.enable = mkDefault true;
      lazygit.enable = mkDefault true;
      nix-index.enable = mkDefault true;
      ripgrep.enable = mkDefault true;
      starship.enable = mkDefault true;
      tmux.enable = mkDefault true;
      yazi.enable = mkDefault true;
      zoxide.enable = mkDefault true;
    };
  };
}
