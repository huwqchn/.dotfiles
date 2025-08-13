return {
  { import = "lazyvim.plugins.extras.editor.mini-files" },
  {
    "echasnovski/mini.files",
    optional = true,
    opts = {
      mappings = {
        go_in = "h",
        go_in_plus = "H",
        go_out = "l",
        go_out_plus = "L",
      },
    },
    keys = {
      { "sm", "<leader>fm", desc = "Mini-files (directory of current file)", remap = true },
      { "sM", "<leader>fM", desc = "Mini-files (cwd)", remap = true },
    },
  },
}
