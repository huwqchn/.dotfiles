return {

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
          augend.constant.new({ elements = { "let", "const" } }),
          augend.constant.new({ elements = { "True", "False" } }),
        },
      })
    end,
  },
}
