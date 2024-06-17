return {
  { import = "lazyvim.plugins.extras.editor.fzf" },
  {
    "linux-cultist/venv-selector.nvim",
    enabled = false,
  },
  {
    "ibhagwan/fzf-lua",
    optional = true,
    keys = {
      { "<c-j>", false },
      { "<c-k>", false },
      { "<c-e>", "<Down>", ft = "fzf", mode = "t", nowait = true },
      { "<c-i>", "<Up>", ft = "fzf", mode = "t", nowait = true },
    },
  },
}
