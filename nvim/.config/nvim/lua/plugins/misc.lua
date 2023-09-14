return {
  -- scopes
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    opts = {},
  },
  -- tidy
  {
    "mcauley-penney/tidy.nvim",
    event = "VeryLazy",
    config = {
      filetype_exclude = { "markdown", "diff" },
    },
  },
  { import = "plugins.extras.misc.dial" },
  { import = "plugins.extras.misc.smart-splits" },
  { import = "plugins.extras.misc.zen-mode" },
  -- { import = "plugins.extras.misc.image" },
  -- { import = "plugins.extras.misc.harpoon" },
  -- { import = "plugins.extras.misc.ghost-text" },
  -- { import = "plugins.extras.misc.neoswap" },
}
