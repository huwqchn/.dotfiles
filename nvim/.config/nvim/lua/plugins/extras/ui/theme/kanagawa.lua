return {
  -- kanigawa
  {
    "rebelot/kanagawa.nvim",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.fillchars:append({
        horiz = "━",
        horizup = "┻",
        horizdown = "┳",
        vert = "┃",
        vertleft = "┨",
        vertright = "┣",
        verthoriz = "╋",
      })
    end,
    opts = {
      globalStatus = true,
      transparent = vim.g.transparent_enabled,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      local colors = require("kanagawa.colors").setup()
      opts.colors = {
        grey = colors.sumiInk4,
        dark_grey = colors.katanaGray,
        black = colors.sumiInk2,
        red = colors.waveRed,
        pink = colors.sakuraPink,
        yellow = colors.autumnYellow,
        blue = colors.springBlue,
        green = colors.springGreen,
        sky = colors.lightBlue,
        cyan = colors.crystalBlue,
        voilet = colors.springViolet1, -- #B4BEFE
        purple = colors.oniViolet,
        teal = colors.dragonBlue,
        white = colors.fujiWhite,
      }
      opts.options.theme = "kanagawa"
    end,
  },
  {
    "petertriho/nvim-scrollbar",
    optional = true,
    opts = function()
      local colors = require("kanagawa.colors").setup()
      return {
        handle = {
          color = colors.sumiInk1,
        },
        marks = {
          Search = { color = colors.surimiOrange },
          Error = { color = colors.samuraiRed },
          Warn = { color = colors.roninYellow },
          Info = { color = colors.waveAqua1 },
          Hint = { color = colors.dragonBlue },
          Misc = { color = colors.oniViolet },
        },
      }
    end,
  },
}
