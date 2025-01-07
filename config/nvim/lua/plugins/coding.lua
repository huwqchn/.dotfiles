return {
  {
    "folke/ts-comments.nvim",
    optional = true,
    opts = {
      lang = {
        lua = "-- %s",
      },
    },
  },
  {
    "echasnovski/mini.ai",
    optional = true,
    keys = {
      { "a", mode = { "x", "o" } },
      { "h", mode = { "x", "o" } },
    },
    opts = {
      n_lines = 500,
      custom_textobjects = {
        w = { "()()%f[%w]%w+()[ \t]*()" },
      },
      mappings = {
        inside = "h",
        inside_next = "hn",
        inside_last = "hl",
      },
    },
  },
  {
    "echasnovski/mini.pairs",
    optional = true,
    event = function()
      return { "InsertEnter" }
    end,
  },
}
