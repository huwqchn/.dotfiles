return {
  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = false,
      interations = {
        notify = true,
        mini = true,
        harpon = true,
        mason = true,
        neogit = true,
        noice = true,
        treesitter_context = true,
        treesitter = true,
        symbols_outline = true,
        which_key = true,
        neo_tree = true,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local colors = require("catppuccin.palettes.mocha")
      opts.colors = {
        grey = colors.surface0,
        dark_grey = colors.overlay0,
        black = colors.base,
        red = colors.red,
        pink = colors.pink,
        yellow = colors.yellow,
        blue = colors.blue,
        green = colors.green,
        sky = colors.sky,
        cyan = colors.sapphire,
        voilet = colors.lavender, -- #B4BEFE
        purple = colors.mauve,
        teal = colors.teal,
        white = colors.text,
      }
      opts.theme = "catppuccin"
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    optional = true,
    opts = function()
      local colors = require("catppuccin.palettes.mocha")
      return {
        handle = {
          color = colors.overlay0,
        },
        marks = {
          Search = { color = colors.maroon },
          Error = { color = colors.red },
          Warn = { color = colors.yellow },
          Info = { color = colors.green },
          Hint = { color = colors.blue },
          Misc = { color = colors.lavender },
        },
      }
    end,
  },
}
