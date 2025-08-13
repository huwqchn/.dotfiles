return {
  { import = "lazyvim.plugins.extras.editor.mini-files" },
  {
    "echasnovski/mini.files",
    optional = true,
    keys = {
      { "sm", "<leader>fm", desc = "Mini-files (directory of current file)", remap = true },
      { "sM", "<leader>fM", desc = "Mini-files (cwd)", remap = true },
    },
  },
}
