{ ... }: 
{
  home.sessionPath = [

  ];

  home.sessionVariables = rec {
    EDITOR = "nvim";
    VISUAL = EDITOR;
    SUDO_EDITOR = EDITOR;
    CFLAGS = "-Wall -O2";
    CXXFLAGS = CFLAGS;
    RUST_BACKTRACE = 1;
    MANPAGER = "nvim +Man!";
    TMUX_TMPDIR = "$HOME/.tmux/tmp";
  };
  
  home.shellAliases = {
    v = "nvim";
    g = "git";
    lg = "lazygit";
  };
}