local config = function(_, opts)
  local colorscheme = require(saturn.colorscheme)
  colorscheme.setup(opts)
  vim.g.colors_name = saturn.colorscheme
  vim.cmd("colorscheme " .. saturn.colorscheme)
end

return {
  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    cond = saturn.colorscheme == "tokyonight",
    priority = 1000,
    init = function()
      if saturn.colorscheme == "tokyonight" then
        local colors = require("tokyonight.colors").setup()
        saturn.colors = {
          grey = colors.bg_highlight,
          dark_grey = colors.fg_dark,
          black = colors.black,
          red = colors.red1,
          pink = colors.red,
          yellow = colors.yellow,
          blue = colors.blue,
          green = colors.green,
          sky = colors.blue1,
          cyan = colors.cyan,
          voilet = colors.magenta,
          purple = colors.purple,
          teal = colors.teal,
          white = colors.fg,
        }
      end
    end,
    opts = {
      on_highlights = function(hl, c)
        hl.IndentBlanklineContextChar = {
          fg = c.dark5,
        }
        hl.TSConstructor = {
          fg = c.blue1,
        }
        hl.TSTagDelimiter = {
          fg = c.dark5,
        }
        hl.IlluminatedWordRead = {
          bg = "#3b4261",
          underline = true,
        }
        hl.IlluminatedWordText = {
          bg = "#3b4261",
          underline = true,
          -- italic = true,
        }
        hl.IlluminatedWordWrite = {
          bg = "#3b4261",
          underline = true,
        }
      end,
      style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
      transparent = saturn.transparent_window, -- Enable this to disable setting the background color
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
      sidebars = {
        "qf",
        "vista_kind",
        "terminal",
        "packer",
        "spectre_panel",
        "NeogitStatus",
        "help",
      },
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
      hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
      dim_inactive = false, -- dims inactive windows
      lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
      use_background = true, -- can be light/dark/auto. When auto, background will be set to vim.o.background
    },
    config = config,
  },

  -- rose-pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    cond = saturn.colorscheme == "rose-pine",
    priority = 1000,
    config = config,
  },

  -- dracula
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    lazy = false,
    cond = saturn.colorscheme == "dracula",
    priority = 1000,
    config = config,
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    cond = saturn.colorscheme == "catppuccin",
    priority = 1000,
    init = function()
      if saturn.colorscheme == "catppuccin" then
        local colors = require("catppuccin.palettes.mocha")
        saturn.colors = {
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
      end
    end,
    opts = {
      transparent_background = saturn.transparent_window,
    },
    config = config,
  },

  -- kanigawa
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    cond = saturn.colorscheme == "kanagawa",
    priority = 1000,
    init = function()
      if saturn.colorscheme == "kanagawa" then
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
        local colors = require("kanagawa.colors").setup()
        saturn.colors = {
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
      end
    end,
    opts = {
      globalStatus = true,
      transparent = saturn.transparent_window,
    },
    config = config,
  },
}
