return {
  {
    "echasnovski/mini.clue",
    event = "VeryLazy",
    opts = {
      triggers = {
        -- custom super key triggers
        { mode = "n", keys = "s", desc = "+Super" },
        { mode = "x", keys = "s", desc = "+Super" },

        -- Leader triggers
        { mode = "n", keys = "<leader>" },
        { mode = "x", keys = "<leader>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },

        { mode = "n", keys = "]" },
        { mode = "n", keys = "[" },
      },
      window = {
        delay = 0,
        config = {
          width = "auto",
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    enabled = false,
    optional = true,
  },
}
