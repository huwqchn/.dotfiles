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
    opts = {
      filetype_exclude = { "markdown", "diff" },
    },
  },
}
