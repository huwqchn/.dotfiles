return {
  -- {
  --   "m4xshen/hardtime.nvim",
  --   event = "BufRead",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = {
  --     restricted_keys = {
  --       ["n"] = { "n", "x" },
  --       ["e"] = { "n", "x" },
  --       ["i"] = { "n", "x" },
  --       ["o"] = { "n", "x" },
  --       ["ge"] = { "n", "x" },
  --       ["gi"] = { "n", "x" },
  --       ["<C-M>"] = { "n", "x" },
  --       ["<C-N>"] = { "n", "x" },
  --       ["<C-P>"] = { "n", "x" },
  --     },
  --   },
  -- },

  {
    "tris203/precognition.nvim",
    event = "BufRead",
    opts = {
      hints = {
        e = { text = "j", prio = 8 },
        E = { text = "J", prio = 5 },
      },
    },
  },
}
