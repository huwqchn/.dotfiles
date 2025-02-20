{emacs-overlay, ...}: {
  programs.emacs = {
    enable = true;
    package = emacs-overlay.overlays.default;
  };
}
