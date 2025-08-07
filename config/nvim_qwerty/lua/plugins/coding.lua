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
    "echasnovski/mini.pairs",
    optional = true,
    event = function()
      return { "InsertEnter" }
    end,
  },
}
