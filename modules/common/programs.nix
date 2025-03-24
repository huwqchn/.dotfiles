{config, ... }: {
  programs = {
    fish.enable = config.shell == "fish";
    bash.enable = config.shell == "bash";
    zsh.enable = config.shell == "zsh";
    nushell.enable = config.shell == "nushell";
  }
}
