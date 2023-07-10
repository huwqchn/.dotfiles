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
      { "<C-=>", function() return require("dial.map").inc_normal() end, mode = "n", expr = true, desc = "Increment" },
      { "<C-->", function() return require("dial.map").dec_normal() end, mode = "n", expr = true, desc = "Decrement" },
      { "g<C-=>", function() return require("dial.map").inc_gnormal() end, mode = "n", expr = true, desc = "Increment" },
      { "g<C-->", function() return require("dial.map").dec_gnormal() end, mode = "n", expr = true, desc = "Decrement" },
      { "<C-=>", function() return require("dial.map").inc_visual() end, mode = "v", expr = true, desc = "Increment" },
      { "<C-->", function() return require("dial.map").dec_visual() end, mode = "v", expr = true, desc = "Decrement" },
      { "g<C-=>", function() return require("dial.map").inc_gvisual() end, mode = "v", expr = true, desc = "Increment" },
      { "g<C-->", function() return require("dial.map").dec_gvisual() end, mode = "v", expr = true, desc = "Decrement" },
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
  -- { import = "plugins.extras.misc.harpoon" },
  {
    "ecthelionvi/NeoSwap.nvim",
    keys = {
      {
        "st",
        "<cmd>NeoSwapNext<cr>",
        desc = "swap word to next",
      },
      {
        "sT",
        "<cmd>NeoSwapPrev<cr>",
        desc = "swap word to previous",
      },
    },
    opts = {},
  },
}
