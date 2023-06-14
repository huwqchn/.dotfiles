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
  -- colorizer
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("colorizer").setup({
        filetypes = { "*", "!lazy" },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = { "*", "!prompt", "!nofile" },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          -- True is same as normal
          tailwind = false, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          virtualtext = "",
        },
      })

      vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = {
          "*.css",
        },
        callback = function()
          require("colorizer").attach_to_buffer(0, { mode = "background", css = true })
        end,
      })
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>m"] = { name = "+marks" },
      },
    },
  },
  -- harpoon
  {
    "christianchiarulli/harpoon",
    keys = {
      { "]m", '<cmd>lua require("harpoon.ui").nav_next()<cr>', desc = "Next Mark File" },
      { "[m", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', desc = "Prev Mark File" },
      { "<leader>fm", "<cmd>Telescope harpoon marks<cr>", desc = "Search Mark Files" },
      { "<leader>m;", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = "Harpoon UI" },
      { "<leader>mm", '<cmd>lua require("harpoon.mark").add_file()<cr>', desc = "Harpoon" },
    },
    config = true,
  },
  -- pick color
  {
    "ziontee113/color-picker.nvim",
    cmd = { "PickColor", "PickColorInsert" },
    config = function()
      require("color-picker").setup({
        ["icons"] = { "ﱢ", "" },
        ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
        ["keymap"] = { -- mapping example:
          ["E"] = "<Plug>ColorPickerSlider5Decrease",
          ["I"] = "<Plug>ColorPickerSlider5Increase",
        },
        ["background_highlight_group"] = "Normal", -- default
        ["border_highlight_group"] = "FloatBorder", -- default
        ["text_highlight_group"] = "Normal", --default
      })
      vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
    end,
  },
  -- {
  --   "ecthelionvi/NeoComposer.nvim",
  --   dependencies = { "kkharji/sqlite.lua" },
  --   keys = {
  --     { "Q", mode = { "n", "v" }, desc = "Plays queued macro" },
  --     { "yq", mode = { "n", "v" }, desc = "Yanks macro" },
  --     { "cq", mode = { "n", "v" }, desc = "Halts macro" },
  --     { "q", mode = { "n", "v" }, desc = "Starts recordong" },
  --     { "<m-q>", mode = { "n", "v" }, desc = "Toggles macro menu" },
  --     { "]Q", mode = "n", desc = "Cycles to next macro" },
  --     { "[Q", mode = "n", desc = "Cycles to previous macro" },
  --   },
  --   cmds = {
  --     "EditMacros",
  --     "ClearNeoComposer",
  --   },
  --   opts = {
  --     -- notify = true,
  --     -- delay_timer = "150",
  --     -- status_bg = colors.black,
  --     -- preview_fg = "#ff9e64",
  --     keymaps = {
  --       play_macro = "Q",
  --       yank_macro = "yq",
  --       stop_macro = "cq",
  --       toggle_record = "q",
  --       cycle_next = "]Q",
  --       cycle_prev = "[Q",
  --       toggle_macro_menu = "<m-q>",
  --     },
  --   },
  -- },
  -- makes some plugins dot-repeatable like leap
  {
    "tpope/vim-repeat",
    event = function()
      return {}
    end,
    keys = {
      ".",
    },
  },
  -- { import = "plugins.extras.misc.smart-splits" },
  { import = "plugins.extras.misc.zen-mode" },
}
