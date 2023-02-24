return {
  {
    "echasnovski/mini.bracketed",
    version = false,
    event = "BufReadPost",
    -- keys = {
    --   { "[", mode = { "n", "x", "o" } },
    --   { "]", mode = { "n", "x", "o" } },
    -- },
    opts = {
      buffer = { suffix = "b", options = {} },
      comment = { suffix = "c", options = {} },
      conflict = { suffix = "x", options = {} },
      diagnostic = { suffix = "d", options = {} },
      file = { suffix = "k", options = {} },
      indent = { suffix = "i", options = {} },
      jump = { suffix = "j", options = {} },
      location = { suffix = "a", options = {} },
      oldfile = { suffix = "o", options = {} },
      quickfix = { suffix = "q", options = {} },
      treesitter = { suffix = "n", options = {} },
      undo = { suffix = "l", options = {} },
      window = { suffix = "w", options = {} },
      yank = { suffix = "y", options = {} },
    },
    config = function(_, opts)
      require("mini.bracketed").setup(opts)
    end,
  },
}
