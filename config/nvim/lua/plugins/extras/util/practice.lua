return {
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      resetting_keys = {
        ["<cr>"] = { "n", "x" }, -- my jump key
        ["<S-cr>"] = { "n", "x" }, -- my jump key
        ["g<cr>"] = { "n", "x", "o" }, -- my jump key
        ["s"] = { "n", "x" }, -- my super key
      },
      hints = {
        ["hx"] = {
          message = function(keys)
            return "Use X instead of " .. keys
          end,
          length = 2,
        },
      },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    enabled = false,
  },
  {
    "tris203/precognition.nvim",
    event = "BufRead",
  },
}
