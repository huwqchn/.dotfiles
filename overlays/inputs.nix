{inputs, ...}: {
  # Export overlays coming from inputs directly
  emacs = inputs.emacs-overlay.overlay;
  treesitter = inputs.nvim-treesitter-main.overlays.default;
}
