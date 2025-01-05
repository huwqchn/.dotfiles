{lib, ...}: {
  imports = [
    ./darwin
    ./cli/atuin.nix
    ./cli/bat.nix
    ./cli/btop.nix
    # ./cli/conda.nix
    ./cli/direnv.nix
    ./cli/eza.nix
    ./cli/fastfetch.nix
    ./cli/fzf.nix
    # ./cli/gh.nix
    ./cli/git.nix
    ./cli/lazygit.nix
    ./cli/nix-index.nix
    ./cli/ripgrep.nix
    ./cli/starship.nix
    ./cli/tmux.nix
    ./cli/yazi.nix
    ./cli/zellij.nix
    ./cli/zoxide.nix
    ./editors/nvim.nix
    ./shells
    ./terminals/ghostty.nix
    # ./themes
    ./home.nix
  ];
  home.persistence = lib.mkForce {};
}
