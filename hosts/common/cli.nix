{
  my = {
    atuin = {
      enable = true;
      autoLogin = true;
    };
    bash.enable = false; #TODO: Temporarily disable bash module to avoid nokogiri via bash-preexec
    bat.enable = false; # TODO: Temporarily disable bat due to nokogiri compilation issues
    btop.enable = true;
    tealdeer.enable = true;
    direnv = {
      enable = true;
      silent = true;
    };
    glow.enable = true;
    zk.enable = true;
    numbat.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    fzf.enable = true;
    gh.enable = true;
    git.enable = true;
    jujutsu.enable = true;
    lazygit.enable = true;
    nix-index.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    tmux.enable = true;
    yazi.enable = true;
    zoxide.enable = true;
    pet.enable = true;
    fuck.enable = true;
    aichat.enable = true;
    claude-code.enable = true;
    codex.enable = true;
    gemini-cli.enable = true;
    opencode.enable = true;
  };
}
