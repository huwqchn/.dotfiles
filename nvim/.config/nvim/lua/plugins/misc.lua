return {
  -- scopes
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = true,
  },
  -- tidy
  {
    "mcauley-penney/tidy.nvim",
    event = "VeryLazy",
    config = {
      filetype_exclude = { "markdown", "diff" },
    },
  },
  -- repeat
  {
    "tpope/vim-repeat",
    event = function()
      return {}
    end,
    keys = {
      ".",
    },
  },
  { import = "plugins.extras.misc.dial" },
  -- { import = "plugins.extras.misc.smart-splits" },
  { import = "plugins.extras.misc.zen-mode" },
  -- { import = "plugins.extras.misc.image" },
  -- { import = "plugins.extras.misc.harpoon" },
  -- { import = "plugins.extras.misc.ghost-text" },
  { import = "plugins.extras.misc.neoswap" },
}
