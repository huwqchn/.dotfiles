return {
  { import = "lazyvim.plugins.extras.editor.fzf" },
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
