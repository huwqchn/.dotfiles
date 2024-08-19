{ wezterm-git,... }: (final: prev: {
  wezterm = wezterm-git.packages.${prev.system}.default;
})
