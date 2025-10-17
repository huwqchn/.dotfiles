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
    "nvim-mini/mini.pairs",
    optional = true,
    event = function()
      return { "InsertEnter" }
    end,
  },
}
