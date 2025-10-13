return {
  { import = "lazyvim.plugins.extras.editor.mini-files" },
  {
    "nvim-mini/mini.files",
    optional = true,
    opts = {
      mappings = {
        go_in = "o",
        go_in_plus = "O",
        go_out = "n",
        go_out_plus = "N",
      },
    },
    keys = {
      { "sm", "<leader>fm", desc = "Mini-files (directory of current file)", remap = true },
      { "sM", "<leader>fM", desc = "Mini-files (cwd)", remap = true },
    },
  },
}
