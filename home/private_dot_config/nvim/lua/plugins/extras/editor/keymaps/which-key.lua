return {
  {
    "folke/which-key.nvim",
    optional = true,
    -- dependencies = {
    --   {
    --     "mrjones2014/legendary.nvim",
    --     -- version = "v2.1.0",
    --     -- since legendary.nvim handles all your keymaps/commands,
    --     -- its recommended to load legendary.nvim before other plugins
    --     priority = 10000,
    --     lazy = false,
    --     opts = {
    --       extensions = {
    --         lazy_nvim = { auto_register = true },
    --       },
    --     },
    --     keys = {
    --       { "<leader>h", "<cmd>Legendary<cr>", mode = { "n", "v" } },
    --       { "<leader>.", "<cmd>LegendaryRepeat<cr>", mode = { "n", "v" } },
    --     },
    --   },
    -- },
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
