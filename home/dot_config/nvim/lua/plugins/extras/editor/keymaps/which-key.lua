return {
  {
    "folke/which-key.nvim",
    optional = true,
    keys = {
      { "<leader>", mode = { "n", "v" } },
      { "g", mode = { "n", "v" } },
      { "s", mode = { "n", "v" } },
      { "[", mode = { "n", "v" } },
      { "]", mode = { "n", "v" } },
    },
    event = function()
      return {}
    end,
    opts = {
      window = {
        border = "single",
      },
      plugins = {
        marks = true,
        registers = true,
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          z = true,
          g = true,
        },
      },
    },
  },
}
