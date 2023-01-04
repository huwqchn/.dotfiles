saturn.plugins.treesitter.rainbow = {
  enable = true,
  extended_mode = false,
  colors = {
    "DodgerBlue",
    "Orchid",
    "Gold",
  },
  disable = { "html" },
}
saturn.plugins.treesitter.ensure_installed = "all"
saturn.plugins.treesitter.textobjects = {
  select = {
    enable = true,
    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ["af"] = "@function.outer",
      ["kf"] = "@function.inner",
      ["at"] = "@class.outer",
      ["kt"] = "@class.inner",
      ["ac"] = "@call.outer",
      ["kc"] = "@call.inner",
      ["aa"] = "@parameter.outer",
      ["ka"] = "@parameter.inner",
      ["al"] = "@loop.outer",
      ["kl"] = "@loop.inner",
      ["ak"] = "@conditional.outer",
      ["kk"] = "@conditional.inner",
      ["a/"] = "@comment.outer",
      ["k/"] = "@comment.inner",
      ["ab"] = "@block.outer",
      ["kb"] = "@block.inner",
      ["as"] = "@statement.outer",
      ["ks"] = "@scopename.inner",
      ["aA"] = "@attribute.outer",
      ["kA"] = "@attribute.inner",
      ["aF"] = "@frame.outer",
      ["kF"] = "@frame.inner",
    },
  },
}
