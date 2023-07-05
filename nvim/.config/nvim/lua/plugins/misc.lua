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
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>m"] = { name = "+marks" },
      },
    },
  },
  -- pick color
  -- {
  --   "ziontee113/color-picker.nvim",
  --   cmd = { "PickColor", "PickColorInsert" },
  --   config = function()
  --     require("color-picker").setup({
  --       ["icons"] = { "ﱢ", "" },
  --       ["border"] = "rounded", -- none | single | double | rounded | solid | shadow
  --       ["keymap"] = { -- mapping example:
  --         ["E"] = "<Plug>ColorPickerSlider5Decrease",
  --         ["I"] = "<Plug>ColorPickerSlider5Increase",
  --       },
  --       ["background_highlight_group"] = "Normal", -- default
  --       ["border_highlight_group"] = "FloatBorder", -- default
  --       ["text_highlight_group"] = "Normal", --default
  --     })
  --     vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
  --   end,
  -- },
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
  -- better increase/descrease
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "+", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "-", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })
    end,
  },
  -- { import = "plugins.extras.misc.smart-splits" },
  { import = "plugins.extras.misc.zen-mode" },
  { import = "plugins.extras.misc.harpon" },
}
