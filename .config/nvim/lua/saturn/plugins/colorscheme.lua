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

  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    cond = saturn.colorscheme == "catppuccin",
    priority = 1000,
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
      end
    end,
    opts = {
      globalStatus = true,
      transparent = saturn.transparent_window,
    },
    config = config,
  },
}
