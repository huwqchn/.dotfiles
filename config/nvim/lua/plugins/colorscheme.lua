return {
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    optional = true,
    opts = {
      on_highlights = function(hl, _)
        hl.StatusLine = { bg = "none" } -- status line of current window
        hl.WinBar = { bg = "none" } -- window bar of current window
        hl.NormalFloat = { bg = "none" } -- set float windows background to transparent
      end,
      style = "moon",
      transparent = true, -- Enable this to disable setting the background color
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local theme = require("lualine.themes.tokyonight")
      theme.normal.c.bg = "none"
      opts.options.theme = theme
    end,
  },
}
